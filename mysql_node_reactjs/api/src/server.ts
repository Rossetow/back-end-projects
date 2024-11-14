import express from 'express';
import userRoutes from './routers/messageRoutes';
const cors = require('cors');

const app = express();

app.use(cors());

app.use(express.json());

app.get('/', (req, res) => {
  res.send('This is the API!');
});

app.use('/api', userRoutes);

const PORT = 5050;
app.listen(PORT, () => {
  console.log(`Server running on http://localhost:${PORT}`);
});

