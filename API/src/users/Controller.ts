import {Router} from "express";
import { UsersRepository } from "./Repository";

const usersController = Router();


usersController.get("/", (req, res) => {
    const users = UsersRepository.getAll();

    res.status(200).send(users);
}