import {Router} from "express";
import { FileRepository } from "./Repository";
import { debug } from "console";
import {upload } from "../services/multer";
import fs from 'fs';

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

filesController.get("/download/:id", async (req, res) => {

    const file = await FileRepository.getFileById(req.params.id)

    if (!file) {
        res.status(404).send({
            status: 404,
            message: "Not found"
        })
        return
    }

    const filePath = file.file;

    res.download(filePath, (err) => {
      if (err) {
        // Gérer les erreurs de téléchargement
        console.error('Erreur lors du téléchargement du fichier :', err);
        res.status(500).send('Une erreur est survenue lors du téléchargement du fichier.');
      }
    });

    //res.status(200).send(file)

})

filesController.post('/',upload.single('file'), async (req, res, next) => {
    try {
      if(req.file != undefined) {
        const fileName = req.file.filename;
        const filePath = req.file.path.replace(/\\/g, "/"); // Remplace les antislashs par des slashs
        debug(fileName);
        const file = {
          user_id: req.body.user_id,
          title: req.body.title,
          file: filePath, // Enregistre le chemin d'accès au fichier dans la base de données
          validated: false,
          dateAdd: new Date(),
          type: req.body.type
        };
  
        const createdFile = await FileRepository.createFile(file);
  
        res.status(200).json(createdFile);
      } else {
        res.status(400).json({ error: 'Aucun fichier n\'a été envoyé' });
      }
    } catch (error) {
      console.error('Erreur lors de la création du fichier :', error);
      res.status(500).json({ error: 'Erreur lors de la création du fichier' });
    }
  });

  filesController.delete('/:id', async (req, res) => {
    try {
      const fileId = req.params.id;
      const file = await FileRepository.getFileById(fileId);
      
      if (!file) {
        res.status(404).json({ error: 'Fichier non trouvé' });
        return;
      }
  
      const filePath = file.file;
      await FileRepository.deleteFile(fileId);
  
      // Supprimer le fichier du serveur
      fs.unlink(filePath, (err) => {
        if (err) {
          console.error('Erreur lors de la suppression du fichier du serveur :', err);
        }
      });
  
      res.status(200).json({ message: 'Fichier supprimé' });
    } catch (error) {
      console.error('Erreur lors de la suppression du fichier :', error);
      res.status(500).json({ error: 'Erreur lors de la suppression du fichier' });
    }
  });


export default filesController;