import {Router} from "express";
import { RequeteRepository } from "./Repository";
import { debug } from "console";

const requetesController = Router();

requetesController.get("/", async (req, res) => {
    const requetes = await RequeteRepository.getAll();

    if (!requetes) {
        res.status(404).send({
            status: 404,
            message: "Not found"
        })
        return
    }

    res.status(200).send(requetes)
})

requetesController.get("/:id", async (req, res) => {
    const requete = await RequeteRepository.getRequetesById(req.params.id);

    if (!requete) {
        res.status(404).send({
            status: 404,
            message: "Not found"
        })
        return
    }

    res.status(200).send(requete)
})

requetesController.get("/user/:id", async (req, res) => {
    const requetes = await RequeteRepository.getRequeteByUser(req.params.id);

    if (!requetes) {
        res.status(404).send({
            status: 404,
            message: "Not found"
        })
        return
    }

    res.status(200).send(requetes)
})

requetesController.get("/valide/:bool", async (req, res) => {
    const requetes = await RequeteRepository.getValidedRequete(req.params.bool);

    if (!requetes) {
        res.status(404).send({
            status: 404,
            message: "Not found"
        })
        return
    }

    res.status(200).send(requetes)
})

requetesController.delete("/:id", async (req, res) => {
    try{
        const requete = await RequeteRepository.getRequetesById(req.params.id);
        
        if(requete){
            await RequeteRepository.deleteRequete(req.params.id);
            res.status(200).send({
                status: 200,
                message: "Deleted"
            })
        }else{
            res.status(404).send({
                status: 404,
                message: "Not found"
            })
        }

    }catch(error){
        res.status(404).send({
            status: 404,
            message: "Not found!",
            error: error
        })
    }
})

requetesController.post("/", async (req, res) => {

    try{
        
        const requete = await RequeteRepository.createRequete(req.body);
        res.status(200).send(requete);
    }catch(error){
        res.status(400).send({
            status: 400,
            message: "Bad requete data",
            error: error
        })
    }
     
})

requetesController.put("/:id", async (req, res) => {
    const requete = await RequeteRepository.getRequetesById(req.params.id);

    if (!requete) {
        res.status(404).send({
            status: 404,
            message: "Not found"
        })
        return
    }

    const updatedRequete = await RequeteRepository.updateRequete(req.body,req.params.id);

    res.status(200).send(updatedRequete)
})

requetesController.get("/type/:type", async (req, res) => {
    const type = req.params.type; // Parse the type parameter as an integer
    const requetes = await RequeteRepository.getRequeteByType(type);

    if (!requetes) {
        res.status(404).send({
            status: 404,
            message: "Not found"
        });
        return;
    }

    res.status(200).send(requetes);
});

export default requetesController