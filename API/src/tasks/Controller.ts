import {Router} from "express";
import {TaskRepository} from "./Repository";

const tasksController = Router();

tasksController.get("/", async (req, res) => {
    const tasks = await TaskRepository.getAll();

    if (!tasks) {
        res.status(404).send({
            status: 404,
            message: "Not found"
        })
        return
    }

    res.status(200).send(tasks)
})

tasksController.get("/:id", async (req, res) => {
    const task = await TaskRepository.getTaskById(req.params.id);

    if (!task) {
        res.status(404).send({
            status: 404,
            message: "Not found"
        })
        return
    }

    res.status(200).send(task)
})

tasksController.get("/user/:user_id", async (req, res) => {
    const tasks = await TaskRepository.getTasksByUser(req.params.user_id);

    if (!tasks) {
        res.status(404).send({
            status: 404,
            message: "Not found"
        })
        return
    }

    res.status(200).send(tasks)
})

tasksController.get("/user/:user_id/type/:type", async (req, res) => {
    const tasks = await TaskRepository.getTasksByUserAndType(req.params.user_id, req.params.type);

    if (!tasks) {
        res.status(404).send({
            status: 404,
            message: "Not found"
        })
        return
    }

    res.status(200).send(tasks)
})

tasksController.delete("/:id", async (req, res) => {
    try{
        await TaskRepository.deleteTask(req.params.id);
        res.status(200).send()
    }catch(error){
        res.status(404).send({
            status: 404,
            message: "Not found!"
        })
    }
})

tasksController.post("/", async (req, res) => {

    try{
        const task = await TaskRepository.createTask(req.body);
        res.status(200).send(task);
    }catch(error){
        res.status(400).send({
            status: 400,
            message: "Bad task data"
        })
    }
    
})

tasksController.put("/:id", async (req, res) => {
    const task = await TaskRepository.getTaskById(req.params.id);

    if (!task) {
        res.status(404).send({
            status: 404,
            message: "Not found"
        })
        return
    }

    const updatedTask = await TaskRepository.updateTask(req.body);

    res.status(200).send(updatedTask)
})

export default tasksController