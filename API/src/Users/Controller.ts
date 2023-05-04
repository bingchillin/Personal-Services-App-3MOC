import { Router } from "express";
import authMiddleware from "../middlewares/authMiddleware";
import User from "./Model";
import usersRepository from "./Repository";

const usersController = Router();

usersController.get("/", async (req, res) => {
    const users = await usersRepository.getAll();
    const user = users[0]
    user


    res.status(200).send(users);
})

usersController.get("/:id", async (req, res) => {
    const user = await usersRepository.getOne(req.params.id);

    if (!user) {
        res.status(404).send({
            status: 404,
            message: "Not found"
        })
        return
    }

    res.status(200).send(user)
})

usersController.post("/", (req, res, next) => {
    usersRepository.createOne(
        req.body
    ).then((errors) => {
        if (errors !== null) {
            res.status(400).send({
                status: 400,
                message: "Bad Request",
                details: errors
            })
            next()
        }

        res.status(201).send({
            status: 201,
            message: "created",
        })

        

    }).catch((err) => {
        next(err)
    })


})

usersController.delete("/:id", async (req, res) => {
    if (await usersRepository.deleteOne(req.params.id)) {
        res.status(204).send()
        return;
    } else {
        res.status(404).send({
            status: 404,
            message: "Not found!"
        })
    }


})





export default usersController