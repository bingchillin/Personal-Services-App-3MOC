import express, { Request, Response } from 'express';
import usersController from './users/Controller';

const app = express();
const port = 3000;

app.use(express.json());

app.get('/', (req: Request, res: Response) => {
  res.send('Hello, World!');
});

app.use("/users", usersController)

app.listen(process.env.PORT || port, () => {
    console.log('Server started');
});