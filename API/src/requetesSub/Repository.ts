import { RequeteSub,validateRequeteSub } from './Model';
import { Pool, PoolConnection } from 'mysql2/promise';

import db from '../services/mysql';

export const RequeteSubRepository = {

  getAll: async (): Promise<RequeteSub[]> => {
    try {
      const connection: PoolConnection = await db.getConnection();
      const [rows] = await connection.query('SELECT * FROM requetes_inscriptions');
      const requetesSub = rows as any;
      return requetesSub;
    } catch (error) {
      throw error;
    }
  },

  getRequetesSubById: async (id: String): Promise<RequeteSub | null> => {
    try {
      const connection: PoolConnection = await db.getConnection();

      const [rows] = await connection.query('SELECT * FROM requetes WHERE id = ?', [id]);

      if (Array.isArray(rows) && rows.length > 0) {
        const user: RequeteSub = rows[0] as RequeteSub;
        return user;
      } else {
        return null;
      }
      
    } catch (error) {
      throw error;
    }
  },

  getRequeteSubByUser: async (id: String): Promise<RequeteSub[] | null> => {
    try {
      const connection: PoolConnection = await db.getConnection();

      const [rows] = await connection.query('SELECT * FROM requetes_inscriptions WHERE user = ?', id);

      if (Array.isArray(rows) && rows.length > 0) {
        const requeteSub = rows as RequeteSub[];
        return requeteSub;
      } else {
        return null;
      }
      
    } catch (error) {
      throw error;
    }
  },

  getRequeteSubByRequete: async (id_req: String): Promise<RequeteSub[] | null> => {
    try {
      const connection: PoolConnection = await db.getConnection();

      const [rows] = await connection.query('SELECT * FROM requetes_inscriptions WHERE requete = ?', id_req);

      if (Array.isArray(rows) && rows.length > 0) {
        const requeteSub = rows as any;
        return requeteSub;
      } else {
        return null;
      }
      
    } catch (error) {
      throw error;
    }
  },

  getValidedRequeteSub: async (bool:String): Promise<RequeteSub[] | null> => {
    try {
      const connection: PoolConnection = await db.getConnection();

      const [rows] = await connection.query('SELECT * FROM requetes_inscriptions WHERE accepted = ?', bool);

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

  createRequeteSub: async (requete: RequeteSub): Promise<RequeteSub> => {
    try {
      const connection: PoolConnection = await db.getConnection();

      const { error } = validateRequeteSub(requete);
      if (error) {
        throw new Error('Données requetes inscriptions invalides');
      }
      const [rows] = await connection.query('INSERT INTO requetes_inscriptions SET ?', requete);
      const createdRequete: RequeteSub = { ...requete};

      return createdRequete;
    } catch (error) {
      throw error;
    }
  },

  updateRequeteSub: async (requete: RequeteSub,id: String): Promise<RequeteSub> => {
    try {
      const connection: PoolConnection = await db.getConnection();

      await connection.query('UPDATE requetes_inscriptions SET ? WHERE id = ?', [requete, id]);

      return requete;
    } catch (error) {
      throw error;
    }
  },

  deleteRequeteSub: async (id: String): Promise<void> => {
    try {
      const connection: PoolConnection = await db.getConnection();

      await connection.query('DELETE FROM requetes_inscriptions WHERE id = ?', [id]);
    } catch (error) {
      throw error;
    }
  },
};
