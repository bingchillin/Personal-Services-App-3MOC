import {Router} from "express";
import { UserRepository } from "./Repository";
import { debug } from "console";

const usersController = Router();

usersController.get("/", async (req, res) => {
    const users = await UserRepository.getAll();

    res.status(200).send(users);
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
export default usersController