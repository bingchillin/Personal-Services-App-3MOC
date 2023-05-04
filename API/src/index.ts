import bodyParser from 'body-parser';
import express from 'express';
import authController from './auth/authController';
import reservationsController from './Reservations/Controller';
import roomsController from './IdentityFile/Controller';
import usersController from './Users/Controller';
import jwt from "jwt-express"
import configService from './services/configService';
import cookieParser from 'cookie-parser';
import errorHandlerMiddleware from './middlewares/errorHandlerMiddleware';

const app = express();

app.use(bodyParser.json())
app.use(jwt.init(configService.JWT_SECRET, { cookies: false, stales: 3600000}))
app.use(cookieParser())


app.get('/', (req, res) => {
    res.send('Hello World!');
})

app.use("/reservations", reservationsController)
app.use("/users", usersController)
app.use("/rooms", roomsController)
app.use("/auth", authController)
app.use(errorHandlerMiddleware)
app.listen(process.env.PORT || 3000, () => {
    console.log('Server started');
});
