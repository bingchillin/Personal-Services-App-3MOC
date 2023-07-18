import {Router} from "express";
import {TypeTaskRepository} from "./Repository";

const typeTasksController = Router();

typeTasksController.get("/", async (req, res) => {
    const typeTasks = await TypeTaskRepository.getAll();

    if (!typeTasks) {
        res.status(404).send({
            status: 404,
            message: "Not found"
        })
        return
    }

    res.status(200).send(typeTasks)
})

typeTasksController.get("/:id", async (req, res) => {
    const typeTask = await TypeTaskRepository.getTypeTaskById(req.params.id);

    if (!typeTask) {
        res.status(404).send({
            status: 404,
            message: "Not found"
        })
        return
    }

    res.status(200).send(typeTask)
})

typeTasksController.delete("/:id", async (req, res) => {
    try{
        await TypeTaskRepository.deleteTypeTask(req.params.id);
        res.status(200).send()
    }catch(error){
        res.status(404).send({
            status: 404,
            message: "Not found!"
        })
    }
})

typeTasksController.post("/", async (req, res) => {

    try{
        const task = await TypeTaskRepository.createTypeTask(req.body);
        res.status(200).send(task);
    }catch(error){
        res.status(400).send({
            status: 400,
            message: "Bad type data"
        })
    }
    
})

typeTasksController.put("/:id", async (req, res) => {
    const typeTask = await TypeTaskRepository.getTypeTaskById(req.params.id);

    if (!typeTask) {
        res.status(404).send({
            status: 404,
            message: "Not found"
        })
        return
    }

    const updatedTypeTask = await TypeTaskRepository.updateTypeTask(req.body);

    res.status(200).send(updatedTypeTask)
})

export default typeTasksController