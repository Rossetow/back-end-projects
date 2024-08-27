package main

import (
	"fmt"
	"log"
	"net/http"
	"sync"
	"github.com/gorilla/websocket"
)

var upgrader = websocket.Upgrader {
	CheckOrigin: func (r *http.Request) bool {
		return true
	},
}

type Client struct {
	conn *websocket.Conn
	send chan []byte
}

type Hub struct {
	clients map[*Client]bool
	mu sync.Mutex
}

func (h *Hub) resgister(client *Client) {
	h.mu.Lock()
	defer h.mu.Unlock()
	h.clients[client] = true
}

func (h *Hub) unregister(client *Client) {
	h.mu.Lock()
	defer h.mu.Unlock()
	delete(h.clients, client)
	close(client.send)
}

func (h *Hub) broadcast(message []byte){
	h.mu.Lock()

	defer h.mu.Unlock()

	for client := range h.clients {
		select {
			case client.send <- message:
			
			default:
				h.unregister(client)

		}
	}
}

func handleConnection(w http.ResponseWriter, r *http.Request, hub *Hub) {
	conn, err := upgrader.Upgrade(w, r, nil)

	if err != nil {
		log.Print("Error while upgrading connection:", err)
		return
	}

	client := &Client{conn: conn, send: make(chan[]byte)}

	hub.resgister(client)

	go client.readMessage(hub)
	go client.writeMessage()
}

func (c *Client) readMessage(hub *Hub) {
	defer func(){
		hub.unregister(c)
		c.conn.Close()
	}()

	for {
		messageType, msg, err := c.conn.ReadMessage()
		if err != nil {
			break
		}
		if messageType == websocket.TextMessage {
			hub.broadcast(msg)
		}
	}
}

func (c *Client) writeMessage() {
	for msg := range c.send {
		if err := c.conn.WriteMessage(websocket.TextMessage, msg); err != nil {
			break;
		}
	}
}

func main() {
	hub := &Hub{clients: make(map[*Client]bool)}

	http.HandleFunc("/ws", func(w http.ResponseWriter, r *http.Request) {
		handleConnection(w, r, hub)
	})

	fmt.Printf("Server started at ws://localhost:8080/ws")

	if err := http.ListenAndServe(":8080", nil); err != nil {
		log.Fatal("Error starting server:", err)
	}
}