import {Router} from "express";
import {TypeRepository} from "./Repository";

const typeController = Router();

typeController.get("/", async (req, res) => {
    const type = await TypeRepository.getAll();

    if (!type) {
        res.status(404).send({
            status: 404,
            message: "Not found"
        })
        return
    }

    res.status(200).send(type)
})

typeController.get("/:id", async (req, res) => {
    const type = await TypeRepository.getTypeById(req.params.id);

    if (!type) {
        res.status(404).send({
            status: 404,
            message: "Not found"
        })
        return
    }

    res.status(200).send(type)
})

typeController.delete("/:id", async (req, res) => {
    try{
        await TypeRepository.deleteType(req.params.id);
        res.status(200).send()
    }catch(error){
        res.status(404).send({
            status: 404,
            message: "Not found!"
        })
    }
})

typeController.post("/", async (req, res) => {

    try{
        const type = await TypeRepository.createType(req.body);
        res.status(200).send(type);
    }catch(error){
        res.status(400).send({
            status: 400,
            message: "Bad type data"
        })
    }
    
})

typeController.put("/:id", async (req, res) => {
    const type = await TypeRepository.getTypeById(req.params.id);

    if (!type) {
        res.status(404).send({
            status: 404,
            message: "Not found"
        })
        return
    }

    const updatedType = await TypeRepository.updateType(req.body);

    res.status(200).send(updatedType)
})

export default typeController