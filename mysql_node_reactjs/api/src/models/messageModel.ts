import pool from "../database";

interface Message {
  title: string;
  content: string;
  date: string;
}

export const getMessages = async (): Promise<Message[]> => {

    const query = "SELECT * FROM Messages;" 

    const [rows] = await pool.query(query);

    return rows as Message[];
  };

export const createMessage = async (message: Message): Promise<void> => {

console.log(message);

  await pool.query('INSERT INTO Messages (title, content, `date`) VALUES (?, ?, ?);', [message.title, message.content, message.date]);
};
