import { Router } from "express";
import usersRepository from "../Users/Repository";


const authController = Router();

authController.post("/login", async (req, res) => {
    const user = await usersRepository.getOneByUsername(req.body.username)

    if (!user) {
        res.status(404).send({
            status: 404,
            message: "User not found"
        })
        return
    }

    if (user.password !== req.body.password) {
        res.status(401).send({
            status: 401,
            message: "Invalid credentials"
        })
        return
    }

    const token = res.jwt({
        username: user.username,
        role: user.role
    })

    res.status(200).send(token)
})

export default authController;

