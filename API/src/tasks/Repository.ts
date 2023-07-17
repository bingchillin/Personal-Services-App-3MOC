import {Task, validateTask} from './Model';
import {PoolConnection} from 'mysql2/promise';

import db from '../services/mysql';

export const TaskRepository = {

  getAll: async (): Promise<Task[]> => {
    try {
      const connection: PoolConnection = await db.getConnection();
      const [rows] = await connection.query('SELECT * FROM tasks');
      const task = rows as any;
      return task;
    } catch (error) {
      throw error;
    }
  },

  getTaskById: async (id: String): Promise<Task | null> => {
    try {
      const connection: PoolConnection = await db.getConnection();

      const [rows] = await connection.query('SELECT * FROM tasks WHERE id = ?', [id]);

      if (Array.isArray(rows) && rows.length > 0) {
        const task: Task = rows[0] as Task;
        return task;
      } else {
        return null;
      }
      
    } catch (error) {
      throw error;
    }
  },


  getTasksByUser: async (id: String): Promise<Task[] | null> => {
    try {
      const connection: PoolConnection = await db.getConnection();

      const [rows] = await connection.query('SELECT * FROM tasks WHERE user_id = ?', id);

      if (Array.isArray(rows) && rows.length > 0) {
        const task = rows as any;
        return task;
      } else {
        return null;
      }
      
    } catch (error) {
      throw error;
    }
  },

  getTasksByUserAndType: async (user_id: String, type: String): Promise<Task[] | null> => {
    try {
      const connection: PoolConnection = await db.getConnection();

      const [rows] = await connection.query('SELECT * FROM tasks WHERE user_id = ? AND type = ?', [user_id, type]);

      if (Array.isArray(rows) && rows.length > 0) {
        const task = rows as any;
        return task;
      } else {
        return null;
      }

    } catch (error) {
      throw error;
    }
  },

  createTask: async (task: Task): Promise<Task> => {
    try {
      const connection: PoolConnection = await db.getConnection();

      const { error } = validateTask(task);
      if (error) {
        throw new Error('Données de la tâche invalides');
      }

      const [rows] = await connection.query('INSERT INTO tasks SET ?', task);
      const id = await connection.query('SELECT LAST_INSERT_ID()');
      const createdTask: Task = { ...task, id: (id as unknown) as number };

      return createdTask;
    } catch (error) {
      throw error;
    }
  },

  updateTask: async (task: Task): Promise<Task> => {
    try {
      const connection: PoolConnection = await db.getConnection();

      await connection.query('UPDATE tasks SET ? WHERE id = ?', [task, task.id]);

      return task;
    } catch (error) {
      throw error;
    }
  },

  deleteTask: async (id: String): Promise<void> => {
    try {
      const connection: PoolConnection = await db.getConnection();

      await connection.query('DELETE FROM tasks WHERE id = ?', [id]);
    } catch (error) {
      throw error;
    }
  },
};
