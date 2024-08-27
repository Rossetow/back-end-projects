package main

import "fmt"

type Node struct {
	data int
	next *Node
}

type List struct {
	head *Node
}

func (l *List) AddAtEnd(data int) {
    newNode := &Node{data: data, next: nil}

    if l.head == nil{
        l.head = newNode
        return
    }

    current := l.head

    for current.next != nil {
        current = current.next
    }

    current.next = newNode
}

func (l *List) AddAtBeggining(data int){

    newNode := &Node{data: data, next: nil}

    if l.head == nil {
        l.head = newNode
        return
    }

    newNode.next = l.head
    l.head = newNode
}

func (l *List) addAfterValue(afterValue, data int){

    newNode := &Node{data: data, next: nil}

    current:= l.head

    for current.next != nil {
        if current.data == afterValue{
            newNode.next = current.next
            current.next = newNode
            return
        }
        current = current.next
    }

    fmt.Printf("It wasn't possible to add %v to list because %d is not defined", data, afterValue)
    fmt.Println()
}

func (l *List) addBeforeValue(beforeValue, data int){

    newNode := &Node{data: data, next: nil}

    if l.head.data == beforeValue {
        newNode.next = l.head
        l.head = newNode
        return
       }

    current:= l.head

    for current.next != nil {
        if current.next.data == beforeValue{
            newNode.next = current.next
            current.next = newNode
            return
        }
        current = current.next
    }

    fmt.Printf("It wasn't possible to add %v to list because %d is not defined", data, beforeValue)
    fmt.Println()
}

func (l *List) removeFirst(){
    if l.head != nil{
        l.head = l.head.next
        return
    }

    fmt.Printf("List if empty")
}

func (l *List) removeLast(){

    if l.head == nil{
        fmt.Println("List is empty.")
        return
    }

    if l.head.next == nil {
        l.head = nil
        return
    }

    current := l.head 

    for current.next != nil {

        if current.next.next == nil {
            current.next = nil
            return
        } 
        current = current.next
    }

}

func (l *List) removeValue(removeValue int) {
    if l.head != nil {
        current := l.head

        for current.next != nil {
            if current.next.data == removeValue {
                current.next = current.next.next
                return
            }
        }

        fmt.Printf("It was not possible to remove %d from the list because it is not defined", removeValue)
        fmt.Println()
    }

    fmt.Println("The list is empty")
}

//Reading the data

func (l *List) PrintList (){
    if l.head != nil {

        current := l.head

        for current != nil {
            fmt.Printf("%d", current.data)
            fmt.Println()

            current = current.next
        }
    }
    fmt.Println("The list is empty")
}

func (l *List) getSize() (int) {
    size := 0
    if l.head != nil {
        current := l.head

        for current != nil{
            current = current.next
            size ++
        }
    }

    return size

}

func (l *List) getNodeAtIndex(index int) (*Node) {

    if l.head == nil{
        fmt.Println("The list is empty")
        return nil
    }

    size := l.getSize()

    if index <= 0 || index > size {
        fmt.Printf("Out of boundaries")
        return nil
    }

    current := l.head

    for i := 0; i < index; i++ {
        current = current.next
    }

    return current
}

func main() {
    myList := List{}

    myList.AddAtBeggining(10)
    myList.AddAtBeggining(20)
    myList.AddAtBeggining(30)

    myList.AddAtEnd(0)


    myList.addAfterValue(10, 15)

    myList.addBeforeValue(20, 25)

    
    fmt.Println("Linked List Contents:")
    myList.PrintList()

    count := myList.getSize()
    fmt.Printf("Total number of nodes: %d\n", count)

    indexToFind := 2
    foundNode := myList.getNodeAtIndex(indexToFind)
    if foundNode != nil {
        fmt.Printf("Node at index %d has data: %d\n", indexToFind, foundNode.data)
    } else {
        fmt.Printf("Node at index %d not found\n", indexToFind)
    }


    myList.removeLast()

    fmt.Println("Linked List After Deletion:")
    myList.PrintList()
}