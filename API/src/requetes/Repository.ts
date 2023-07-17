import { Requete,validateRequete } from './Model';
import { Pool, PoolConnection } from 'mysql2/promise';

import db from '../services/mysql';
import { debug } from 'console';

export const RequeteRepository = {

  getAll: async (): Promise<Requete[]> => {
    try {
      const connection: PoolConnection = await db.getConnection();
      const [rows] = await connection.query('SELECT * FROM requetes');
      const requetes = rows as any;
      return requetes;
    } catch (error) {
      throw error;
    }
  },

  getRequetesById: async (id: String): Promise<Requete | null> => {
    try {
      const connection: PoolConnection = await db.getConnection();

      const [rows] = await connection.query('SELECT * FROM requetes WHERE id = ?', [id]);

      if (Array.isArray(rows) && rows.length > 0) {
        const requete: Requete = rows[0] as Requete;
        return requete;
      } else {
        return null;
      }
      
    } catch (error) {
      throw error;
    }
  },

  getRequeteByUser: async (id: String): Promise<Requete[] | null> => {
    try {
      const connection: PoolConnection = await db.getConnection();

      const [rows] = await connection.query('SELECT * FROM requetes WHERE client = ?', id);

      if (Array.isArray(rows) && rows.length > 0) {
        const requete = rows as Requete[];
        return requete;
      } else {
        return null;
      }
      
    } catch (error) {
      throw error;
    }
  },

  getRequeteByType: async (type: String): Promise<Requete[] | null> => {
    try {
      const connection: PoolConnection = await db.getConnection();

      const [rows] = await connection.query('SELECT * FROM requetes WHERE type = ?', type);

      if (Array.isArray(rows) && rows.length > 0) {
        const requetes = rows as any;
        return requetes;
      } else {
        return null;
      }
      
    } catch (error) {
      throw error;
    }
  },

  getValidedRequete: async (bool:String): Promise<Requete[] | null> => {
    try {
      const connection: PoolConnection = await db.getConnection();

      const [rows] = await connection.query('SELECT * FROM users WHERE validated = ?', bool);

      if (Array.isArray(rows) && rows.length > 0) {
        const user = rows as any;
        return user;
      } else {
        return null;
      }
      
    } catch (error) {
      throw error;
    }
  },

  createRequete: async (requete: Requete): Promise<Requete> => {
    try {
      const connection: PoolConnection = await db.getConnection();

      delete requete.id;
      requete.done = false;

      const { error } = validateRequete(requete);

      if (error) {
        throw new Error('Données requetes invalides ' + error);

      }

      

      const [rows] = await connection.query('INSERT INTO requetes SET ?', requete);
      const createdRequete: Requete = { ...requete};

      return createdRequete;
    } catch (error) {
      throw error;
    }
  },

  updateRequete: async (requete: Requete,id: String): Promise<Requete> => {
    try {
      const connection: PoolConnection = await db.getConnection();

      await connection.query('UPDATE requetes SET ? WHERE id = ?', [requete, id]);

      return requete;
    } catch (error) {
      throw error;
    }
  },

  deleteRequete: async (id: String): Promise<void> => {
    try {
      const connection: PoolConnection = await db.getConnection();

      await connection.query('DELETE FROM requetes WHERE id = ?', [id]);
    } catch (error) {
      throw error;
    }
  },
};
