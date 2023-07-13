import {Router} from "express";
import { UserRepository } from "./Repository";
import { debug } from "console";

const usersController = Router();

usersController.get("/", async (req, res) => {
    const users = await UserRepository.getAll();

    if (!users) {
        res.status(404).send({
            status: 404,
            message: "Not found"
        })
        return
    }

    res.status(200).send(users)
})

usersController.get("/:id", async (req, res) => {
    const user = await UserRepository.getUserById(req.params.id);

    if (!user) {
        res.status(404).send({
            status: 404,
            message: "Not found"
        })
        return
    }

    res.status(200).send(user)
})

usersController.delete("/:id", async (req, res) => {
    try{
        await UserRepository.deleteUser(req.params.id);
        res.status(204).send()
    }catch(error){
        res.status(404).send({
            status: 404,
            message: "Not found!"
        })
    }
})

usersController.post("/", async (req, res) => {

    try{
        const user = await UserRepository.createUser(req.body);
        res.status(201).send(user);
    }catch(error){
        res.status(400).send({
            status: 400,
            message: "Bad user data"
        })
    }
    

    
})

usersController.put("/:id", async (req, res) => {
    const user = await UserRepository.getUserById(req.params.id);

    if (!user) {
        res.status(404).send({
            status: 404,
            message: "Not found"
        })
        return
    }

    const updatedUser = await UserRepository.updateUser(req.body);

    res.status(200).send(updatedUser)
})

export default usersController