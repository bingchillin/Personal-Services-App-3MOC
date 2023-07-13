import { validateFile,File } from './Model';
import { Pool, PoolConnection } from 'mysql2/promise';

import db from '../services/mysql';

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
      }
    ,

    createFile: async (file: File): Promise<File> => {
        try {
            const connection: PoolConnection = await db.getConnection();
    
            const { error } = validateFile(file);
            if (error) {
            throw new Error('Données fichier invalides');
            }
            const [rows] = await connection.query('INSERT INTO files SET ?', file);
            const createdFile: File = { ...file};
    
            return createdFile;
        } catch (error) {
            throw error;
        }
    },
    
}