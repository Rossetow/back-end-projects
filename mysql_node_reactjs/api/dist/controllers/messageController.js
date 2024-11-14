"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.addMessage = exports.getAllMessages = void 0;
const messageModel_1 = require("../models/messageModel");
const getAllMessages = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const messages = yield (0, messageModel_1.getMessages)();
        res.json(messages);
    }
    catch (error) {
        console.log(error);
        res.status(500).json({ error: 'Error' });
    }
});
exports.getAllMessages = getAllMessages;
const addMessage = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    console.log("fjkefhhshsefhsfhfhsesef");
    const { title, content } = req.body;
    var today = new Date();
    var dd = String(today.getDate()).padStart(2, '0');
    var mm = String(today.getMonth() + 1).padStart(2, '0'); //January is 0!
    var yyyy = today.getFullYear();
    const date = dd + '/' + mm + '/' + yyyy;
    try {
        yield (0, messageModel_1.createMessage)({ title, content, date });
        res.status(201).json({ message: 'Message saved successfuly!' });
    }
    catch (error) {
        console.log(error);
        res.status(500).json({ error: 'Error saving message' });
    }
});
exports.addMessage = addMessage;
