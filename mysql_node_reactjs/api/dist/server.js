"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = __importDefault(require("express"));
const messageRoutes_1 = __importDefault(require("./routers/messageRoutes"));
const cors = require('cors');
const app = (0, express_1.default)();
app.use(cors());
app.use(express_1.default.json());
app.get('/', (req, res) => {
    res.send('This is the API!');
});
app.use('/api', messageRoutes_1.default);
const PORT = 5050;
app.listen(PORT, () => {
    console.log(`Server running on http://localhost:${PORT}`);
});
