"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = require("express");
const messageController_1 = require("../controllers/messageController");
const cors = require('cors');
const router = (0, express_1.Router)();
router.get('/messages', messageController_1.getAllMessages);
router.post('/messages', messageController_1.addMessage);
router.get('/');
exports.default = router;
