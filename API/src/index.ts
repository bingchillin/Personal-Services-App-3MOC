import express, { Request, Response } from 'express';
import con from './services/mysql';
import mysql from 'mysql2';

const app = express();
const port = 3000;

app.use(express.json());

app.get('/', (req: Request, res: Response) => {
  res.send('Hello, World!');
});

app.listen(process.env.PORT || port, () => {
    console.log('Server started');

    con.connect((error) => {
      if (error) {
        console.error('Erreur de connexion à la base de données :', error);
        return;
      }
      console.log('Connexion à la base de données établie !');
    });
});