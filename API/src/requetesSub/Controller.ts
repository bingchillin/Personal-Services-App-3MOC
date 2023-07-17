import {Router} from "express";
import { RequeteSubRepository } from "./Repository";
import { debug } from "console";

const requetesSubController = Router();

requetesSubController.get("/", async (req, res) => {
    const requetes = await RequeteSubRepository.getAll();

    if (!requetes) {
        res.status(404).send({
            status: 404,
            message: "Not found"
        })
        return
    }

    res.status(200).send(requetes)
})

requetesSubController.get("/:id", async (req, res) => {
    const requete = await RequeteSubRepository.getRequetesSubById(req.params.id);

    if (!requete) {
        res.status(404).send({
            status: 404,
            message: "Not found"
        })
        return
    }

    res.status(200).send(requete)
})

requetesSubController.get("/user/:id", async (req, res) => {
    const requetes = await RequeteSubRepository.getRequeteSubByUser(req.params.id);

    if (!requetes) {
        res.status(404).send({
            status: 404,
            message: "Not found"
        })
        return
    }

    res.status(200).send(requetes)
})

requetesSubController.get("/valide/:bool", async (req, res) => {
    const requetes = await RequeteSubRepository.getValidedRequeteSub(req.params.bool);

    if (!requetes) {
        res.status(404).send({
            status: 404,
            message: "Not found"
        })
        return
    }

    res.status(200).send(requetes)
})

requetesSubController.delete("/:id", async (req, res) => {
    try{
        await RequeteSubRepository.deleteRequete(req.params.id);
        res.status(200).send()
    }catch(error){
        res.status(404).send({
            status: 404,
            message: "Not found!"
        })
    }
})

requetesSubController.post("/", async (req, res) => {

    try{
        const requete = await RequeteSubRepository.createRequeteSub(req.body);
        res.status(200).send(requete);
    }catch(error){
        res.status(400).send({
            status: 400,
            message: "Bad requete data"
        })
    }
    
})

requetesSubController.put("/:id", async (req, res) => {
    const requete = await RequeteSubRepository.getRequetesSubById(req.params.id);

    if (!requete) {
        res.status(404).send({
            status: 404,
            message: "Not found"
        })
        return
    }

    const updatedRequete = await RequeteSubRepository.updateRequeteSub(req.body, req.params.id);

    res.status(200).send(updatedRequete)
})

export default requetesSubController