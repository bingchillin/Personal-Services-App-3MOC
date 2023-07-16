import {TypeTask, validateTypeTask} from './Model';
import {PoolConnection} from 'mysql2/promise';

import db from '../services/mysql';

export const TypeTaskRepository = {

  getAll: async (): Promise<TypeTask[]> => {
    try {
      const connection: PoolConnection = await db.getConnection();
      const [rows] = await connection.query('SELECT * FROM typetasks');
      const typetask = rows as any;
      return typetask;
    } catch (error) {
      throw error;
    }
  },

  getTypeTaskById: async (id: String): Promise<TypeTask | null> => {
    try {
      const connection: PoolConnection = await db.getConnection();

      const [rows] = await connection.query('SELECT * FROM typetasks WHERE id = ?', [id]);

      if (Array.isArray(rows) && rows.length > 0) {
        const typetask: TypeTask = rows[0] as TypeTask;
        return typetask;
      } else {
        return null;
      }
      
    } catch (error) {
      throw error;
    }
  },


  createTypeTask: async (typeTask: TypeTask): Promise<TypeTask> => {
    try {
      const connection: PoolConnection = await db.getConnection();

      const { error } = validateTypeTask(typeTask);
      if (error) {
        throw new Error('Données du type de tâche invalides');
      }

      const [rows] = await connection.query('INSERT INTO typetasks SET ?', typeTask);
      const createdTypeTask: TypeTask = { ...typeTask};

      return createdTypeTask;
    } catch (error) {
      throw error;
    }
  },

  updateTypeTask: async (typeTask: TypeTask): Promise<TypeTask> => {
    try {
      const connection: PoolConnection = await db.getConnection();

      await connection.query('UPDATE typetasks SET ? WHERE id = ?', [typeTask, typeTask.id]);

      return typeTask;
    } catch (error) {
      throw error;
    }
  },

  deleteTypeTask: async (id: String): Promise<void> => {
    try {
      const connection: PoolConnection = await db.getConnection();

      await connection.query('DELETE FROM typetasks WHERE id = ?', [id]);
    } catch (error) {
      throw error;
    }
  },
};
