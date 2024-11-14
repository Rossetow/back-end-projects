import { Router } from 'express';
import { getAllMessages, addMessage } from '../controllers/messageController';
const cors = require('cors');

const router = Router();

router.get('/messages', getAllMessages);

router.post('/messages', addMessage);

router.get('/', )

export default router;