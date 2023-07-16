import multer from "multer";
import path from "path";
import fs from "fs";

const storage = multer.diskStorage({
  destination: (req, file, cb) => {
  const uploadDestination = `uploads/${req.body.user_id}`;

  // Vérifier si le dossier d'upload existe, sinon le créer
  if (!fs.existsSync(uploadDestination)) {
    fs.mkdirSync(uploadDestination, { recursive: true });
  }

  cb(null, uploadDestination);
},
filename: (req, file, cb) => {
  const uniqueSuffix = Date.now() + "-" + Math.round(Math.random() * 1e9);
  const fileExtension = path.extname(file.originalname);
  const fileName = req.body.title + "-" + uniqueSuffix + fileExtension;

  cb(null, fileName.replace(/ /g, "-"));
}
});

export const upload = multer({
storage: storage,
    fileFilter: (req, file, cb) => {
      const fileExtension = path.extname(file.originalname);
      const allowedExtensions = ['.pdf', '.png', '.jpg', '.jpeg'];

      if (!allowedExtensions.includes(fileExtension)) {
        return cb(new Error('Type de fichier non autorisé'));
      }

      cb(null, true);
    },
  });