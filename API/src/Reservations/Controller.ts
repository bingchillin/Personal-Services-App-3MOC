import { Router } from "express";
import reservationsRepository from "./Repository";
import authMiddleware from '../middlewares/authMiddleware';
import NotFoundError from "../errors/NotFoundError";
import ValidationError from "../errors/ValidationError";

const reservationsController = Router();

reservationsController.get("/", (req, res) => {
    const reservations = reservationsRepository.getAll();

    res.status(200).send(reservations);
})

reservationsController.get("/:id", (req, res) => {
    const reservation = reservationsRepository.getOne(req.params.id);

    if (!reservation) {
        res.status(404).send({
            status: 404,
            message: "Not found"
        })
        return
    }

    res.status(200).send(reservation)
})

reservationsController.post("/", authMiddleware(["user", "admin"]), async (req, res) => {
    const errors = await reservationsRepository.createOne(
        req.body
    )

    if (errors) {
        res.status(400).send({
            status: 400,
            message: "Bad Request",
            details: errors
        })
        return
    }

    res.status(201).send({
        status: 201,
        message: "created",
    })
})

reservationsController.delete("/:id",async (req, res) => {
    if (await reservationsRepository.deleteOne(req.params.id)) {
        res.status(204).send()
        return;
    } else {
        res.status(404).send({
            status: 404,
            message: "Not found!"
        })
    }


})


reservationsController.patch("/cancel/:id",
    authMiddleware(["user", "admin"]),
    (req, res) => {
        const id = req.params.id

        try {
            const result = reservationsRepository.updateOne(id, {
                cancelled: true,
            })


            res.status(200).send({
                message: "Modified",
                content: result
            })
        }
        catch (e) {
            if (e instanceof NotFoundError) {
                res.status(404).send({
                    status: 404,
                    message: "Not found!"
                })
            } else if (e instanceof ValidationError) {
                res.status(400).send({
                    status: 400,
                    message: "Bad Request",
                    details: e.errorDetails
                })
            } else {
                res.status(500).send({
                    status: 500,
                    message: "Internal Error",
                })
            }
        }

    })




export default reservationsController