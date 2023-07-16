import multer from "multer";
import path from "path";

export const upload = multer({
    dest: 'uploads/',
     fileFilter: (req, file, cb) => {
       const fileExtension = path.extname(file.originalname);
       const allowedExtensions = ['.pdf', '.png', '.jpg', '.jpeg'];
 
       if (!allowedExtensions.includes(fileExtension)) {
         return cb(new Error('Type de fichier non autorisé'));
       }
 
       cb(null, true);
     },
   });