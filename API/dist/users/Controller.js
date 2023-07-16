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
const express_1 = require("express");
const Repository_1 = require("./Repository");
const usersController = (0, express_1.Router)();
usersController.get("/", (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    const users = yield Repository_1.UserRepository.getAll();
    if (!users) {
        res.status(404).send({
            status: 404,
            message: "Not found"
        });
        return;
    }
    res.status(200).send(users);
}));
usersController.get("/:id", (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    const user = yield Repository_1.UserRepository.getUserById(req.params.id);
    if (!user) {
        res.status(404).send({
            status: 404,
            message: "Not found"
        });
        return;
    }
    res.status(200).send(user);
}));
usersController.delete("/:id", (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        yield Repository_1.UserRepository.deleteUser(req.params.id);
        res.status(204).send();
    }
    catch (error) {
        res.status(404).send({
            status: 404,
            message: "Not found!"
        });
    }
}));
usersController.post("/", (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const user = yield Repository_1.UserRepository.createUser(req.body);
        res.status(201).send(user);
    }
    catch (error) {
        res.status(400).send({
            status: 400,
            message: "Bad user data"
        });
    }
}));
usersController.put("/:id", (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    const user = yield Repository_1.UserRepository.getUserById(req.params.id);
    if (!user) {
        res.status(404).send({
            status: 404,
            message: "Not found"
        });
        return;
    }
    const updatedUser = yield Repository_1.UserRepository.updateUser(req.body);
    res.status(200).send(updatedUser);
}));
exports.default = usersController;
