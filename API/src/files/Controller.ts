import {Router} from "express";
import { FileRepository } from "./Repository";
import multer from "multer";
import { debug } from "console";

const upload = multer({ dest: 'uploads/' });
const filesController = Router();

filesController.get("/", async (req, res) => {
    const files = await FileRepository.getAll();

    if (!files) {
        res.status(404).send({
            status: 404,
            message: "Not found"
        })
        return
    }

    res.status(200).send(files)
})

filesController.post('/', upload.single('file'), async (req, res) => {
    try {
      const path = req.file;
  
      const file = {
        id: 0,
        user_id: req.body.user_id,
        title: req.body.title,
        file: path, // Enregistre le chemin d'accès au fichier dans la base de données
        validated: false,
        type: req.body.type
      };
  
      const createdFile = await FileRepository.createFile(file);
  
      res.status(200).json(createdFile);
    } catch (error) {
      console.error('Erreur lors de la création du fichier :', error);
      res.status(500).json({ error: 'Erreur lors de la création du fichier' });
    }
  });

export default filesController;