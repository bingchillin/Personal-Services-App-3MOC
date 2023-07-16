import express, { Request, Response } from 'express';
import usersController from './users/Controller';
import authController from './auth/authController';
import fileController from './files/Controller';
import requetesController from './requetes/Controller';
import swaggerUi from 'swagger-ui-express';
import swaggerJSDoc from 'swagger-jsdoc';
import bodyParser from 'body-parser';
import tasksController from "./tasks/Controller";
import typeTasksController from "./typetasks/Controller";

//Server
const app = express();
const port = 3000;

//swagger
const swaggerOptions = {
  swaggerDefinition: {
    info: {
      title: 'API',
      version: '1.0.0',
      description: 'Users API Information',
      contact: {
        name: 'Amazing Developer'
      },
    }
  },
  apis: ['src/index.ts'],
};

const swaggerDocs = swaggerJSDoc(swaggerOptions);


//Routes
app.use('/api-docs', swaggerUi.serve, swaggerUi.setup(swaggerDocs));
app.use(express.json());
app.use(bodyParser.json());

app.get('/', (req: Request, res: Response) => {
  res.send('Hello, World!');
});

/**
 * @swagger
 * /users:
 *  get:
 *    description: Use to request all users
 *    responses:
 *      '200':
 *        description: A successful response
 *      '404':
 *        description: Not found
 *  post:
 *    description: Use to creat a user
 *    consumes:
 *       - application/json
 *    responses:
 *      '200':
 *        description: A successful response
 *      '401':
 *        description: Invalid credentials
 * 
 * /users/:id:
 *  get:
 *    description: Use to request all users
 *    responses:
 *      '200':
 *        description: A successful response
 *      '404':
 *        description: Not found
 *  delete:
 *    description: Use to delete users by id
 *    parameters:
 *      - id: id
 *        description: user id
 *    responses:
 *      '200':
 *        description: Delete successful
 *      '404':
 *        description: Not found
 *  post:
 *    description: Use to creat a user
 *    responses:
 *      '200':
 *        description: A successful response
 *      '401':
 *        description: Invalid credentials
 *  put:
 *    description: Use to update a user
 *    responses:
 *      '200':
 *        description: A successful response
 *      '401':
 *        description: Invalid credentials
 * 
 */
app.use("/users", usersController)

/**
 * @swagger
 * /login:
 *  post:
 *    description: Use to get a user by email and password
 *    parameters:
 *      - email: email
 *        description: user email
 *      - password: password
 *        description: user password
 *    responses:
 *      '200':
 *        description: A successful response
 *      '401':
 *        description: Invalid credentials
 *  
 */
app.use("/login", authController)

app.use("/files",fileController)

app.use("/requetes",requetesController)

app.use("/tasks",tasksController)

app.use("/typetask",typeTasksController)

app.listen(process.env.PORT || port, () => {
    console.log('Server started');
});