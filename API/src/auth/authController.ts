import { Router } from "express";
import { UserRepository } from "../users/Repository";

const authController = Router();

authController.post('/', async (req, res) => {
    const { email, password } = req.body;
    const user = await UserRepository.getUserByLogs(email,password);

    if (user) {
        res.status(201).json({ message: 'Login successful' });
    } else {
        res.status(401).json({ message: 'Invalid credentials' });
    }
    }
);

export default authController;