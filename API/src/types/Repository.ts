import {Type, validateType} from './Model';
import {PoolConnection} from 'mysql2/promise';

import db from '../services/mysql';

export const TypeRepository = {

  getAll: async (): Promise<Type[]> => {
    try {
      const connection: PoolConnection = await db.getConnection();
      const [rows] = await connection.query('SELECT * FROM types');
      const type = rows as any;
      return type;
    } catch (error) {
      throw error;
    }
  },

  getTypeById: async (id: String): Promise<Type | null> => {
    try {
      const connection: PoolConnection = await db.getConnection();

      const [rows] = await connection.query('SELECT * FROM types WHERE id = ?', [id]);

      if (Array.isArray(rows) && rows.length > 0) {
        const type: Type = rows[0] as Type;
        return type;
      } else {
        return null;
      }
      
    } catch (error) {
      throw error;
    }
  },


  createType: async (type: Type): Promise<Type> => {
    try {
      const connection: PoolConnection = await db.getConnection();

      const { error } = validateType(type);
      if (error) {
        throw new Error('Données du type invalides');
      }

      const [rows] = await connection.query('INSERT INTO types SET ?', type);
      const createdType: Type = { ...type};

      return createdType;
    } catch (error) {
      throw error;
    }
  },

  updateType: async (type: Type): Promise<Type> => {
    try {
      const connection: PoolConnection = await db.getConnection();

      await connection.query('UPDATE types SET ? WHERE id = ?', [type, type.id]);

      return type;
    } catch (error) {
      throw error;
    }
  },

  deleteType: async (id: String): Promise<void> => {
    try {
      const connection: PoolConnection = await db.getConnection();

      await connection.query('DELETE FROM types WHERE id = ?', [id]);
    } catch (error) {
      throw error;
    }
  },
};
