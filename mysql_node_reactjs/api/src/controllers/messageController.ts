import { Request, Response } from 'express';
import { getMessages, createMessage } from '../models/messageModel';

export const getAllMessages = async (req: Request, res: Response) => {

  try {
    const messages = await getMessages();
    res.json(messages);
  } catch (error) {    
    res.status(500).json({ error: 'Error' });
  }
};

export const addMessage = async (req: Request, res: Response) => {    

    const { title, content} = req.body.data;
       
    var today = new Date();
    var dd = String(today.getDate()).padStart(2, '0');
    var mm = String(today.getMonth() + 1).padStart(2, '0'); //January is 0!
    var yyyy = today.getFullYear();

    const date = dd + '/' + mm + '/' + yyyy;

    try {
        await createMessage({ title, content, date });
        res.status(201).json({ message: 'Message saved successfuly!' });
    } catch (error) {        
        res.status(500).json({ error: 'Error saving message' });
    }
};
