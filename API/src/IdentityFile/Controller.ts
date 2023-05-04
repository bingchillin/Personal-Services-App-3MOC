import { Router } from "express";
import authMiddleware from "../middlewares/authMiddleware";
import docsRepository from "./Repository";

const docsController = Router();

docsController.get("/", (req, res) => {
    const docs = docsRepository.getAll();

    res.status(200).send(docs);
})

docsController.get("/:id", (req, res) => {
    const room = docsRepository.getOne(req.params.id);

    if (!room) {
        res.status(404).send({
            status: 404,
            message: "Not found"
        })
        return
    }

    res.status(200).send(room)
})

docsController.post("/", authMiddleware(["admin"]), (req, res) => {
    const errors = docsRepository.createOne(
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

docsController.delete("/:id", authMiddleware(["admin"]), async (req, res) => {
    if (await docsRepository.deleteOne(req.params.id)) {
        res.status(204).send()
        return;
    } else {
        res.status(404).send({
            status: 404,
            message: "Not found!"
        })
    }


})





export default docsController