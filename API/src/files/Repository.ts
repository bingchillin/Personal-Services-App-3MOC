import { validateFile,File } from './Model';
import { Pool, PoolConnection } from 'mysql2/promise';
import {upload} from "../services/multer";

import db from '../services/mysql';
import { debug } from 'console';

export const FileRepository = {

    getAll: async (): Promise<File[]> => {
      try {
          const connection: PoolConnection = await db.getConnection();
          const [rows] = await connection.query('SELECT * FROM files');
          
          const file = rows as any;
          return file;
        
      } catch (error) {
        throw error;
      }
    },

    createFile: async (file: File): Promise<File> => {
        try {
          const connection: PoolConnection = await db.getConnection();
      
          const { error } = validateFile(file);
          if (error) {
            throw new Error('Données fichier invalides');
          }
      
          // Insérer les informations du fichier dans la base de données
          const [rows] = await connection.query('INSERT INTO files SET ?', file);
          
          // Récupérer l'ID généré pour le fichier inséré
          const fileId = (rows as any).insertId;
      
          // Mettre à jour le chemin du fichier avec le chemin de destination Multer
          const filePath = `uploads/${file.user_id}/${file.file}`;
          
          // Mettre à jour l'objet File avec le chemin du fichier
          const updatedFile: File = { ...file, file: filePath };
      
          // Répondre avec le fichier créé
          return updatedFile;
        } catch (error) {
          throw error;
        }
      },


      getFileById: async (id: String): Promise<File> => {
        try {
          const connection: PoolConnection = await db.getConnection();
          const [rows] = await connection.query('SELECT * FROM files WHERE id = ?', [id]);
          if (Array.isArray(rows) && rows.length > 0) {
            const file: File = rows[0] as File;
            return file;
          } else {
            throw new Error('Fichier non trouvé');
          }
        } catch (error) {
          throw error;
        }
      },

      deleteFile: async (id: String): Promise<void> => {
        try {
          const connection: PoolConnection = await db.getConnection();
          await connection.query('DELETE FROM files WHERE id = ?', [id]);
        } catch (error) {
          throw error;
        }
      }

    
}