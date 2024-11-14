import React, { useEffect, useState } from 'react';
import axios from 'axios'

function App() {

  const [messages, setMessages] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const [title, setTitle] = useState("");
  const [content, setContent] = useState("");
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [message, setMessage] = useState("");
  const [isFormVisible, setIsFormVisible] = useState(false); // Estado para controlar a visibilidade do formulário

  const toggleFormVisibility = () => {
    setIsFormVisible(!isFormVisible);
  };

  const api = axios.create({
    baseURL: 'http://localhost:5050/api/messages'
  });

  api.defaults.headers.post['Access-Control-Allow-Origin'] = '*';

  const fetchMessages = async () => {

    api.get("/")
      .then((res) => {
        if (!res.statusText) {
          throw new Error("Error loading messages");   
        }

        const data = res.data;
        setMessages(data);
      })

      .catch(err => {
        console.log(err);
        
        setError(err.message);
      })

      .finally(() => {
        setLoading(false);
      })
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    
    const formData = {
      title: title,
      content: content,
    };

    try {
      setIsSubmitting(true);
      setMessage("");

      const response = await api.post("/",{
        headers: {"Content-Type": "application/json" },
        method: 'POST',
        data: {
          title: title,
          content: content
        }
      })

      if (response.ok) {
        setMessage("Message sent!");
        setTitle("");
        setContent("");
      } else {
        throw new Error("Error sending message");
      }
    } catch (err) {
      setMessage(`Erro: ${err.message}`);
    } finally {
      setIsSubmitting(false);
      setIsFormVisible(false);
      fetchMessages()
    }
  };

  useEffect(() => {
    fetchMessages();
  }, []);

  if (loading) {
    return <div>Loading messages...</div>;
  }

  if (error) {
    return <div>Error: {error}</div>;
  }
  return (
    <div>
      <h1>Messages</h1>

      <ul>
        {messages.length === 0 ? <li><h3>You haven' sent any messages yet</h3></li>
        :
        messages.map((message) => (
          <li key={message.id}>
            <h3>{message.title}</h3>
            <p>{message.content}</p>
            <small>{message.date}</small>
          </li>
        ))}
      </ul>

      <h1>Send message</h1>

      <button onClick={toggleFormVisibility}>
        {isFormVisible ? "Cancel" : "Write message"}
      </button>

      {isFormVisible && (
        <div>
          <h1>Send message</h1>

          <form onSubmit={handleSubmit}>
            <div>
              <label htmlFor="title">Title:</label>
              <input
                type="text"
                id="title"
                value={title}
                onChange={(e) => setTitle(e.target.value)}
                required
              />
            </div>

            <div>
              <label htmlFor="content">Content:</label>
              <textarea
                id="content"
                value={content}
                onChange={(e) => setContent(e.target.value)}
                required
              ></textarea>
            </div>

            <div>
              <button type="submit" disabled={isSubmitting}>
                {isSubmitting ? "Sending..." : "Send"}
              </button>
            </div>
          </form>

          {message && <p>{message}</p>}
        </div>
      )}
    </div>
  );
}

export default App;
