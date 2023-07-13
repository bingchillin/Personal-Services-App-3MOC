import { Router } from "express";
import { UserRepository } from "../users/Repository";

const authController = Router();

authController.post('/login', async (req, res) => {
    const { email, password } = req.body;
    const user = await UserRepository.getUserByLogs(email,password);

    if (user) {
        res.json({ message: 'Login successful' });
    } else {
        res.status(401).json({ message: 'Invalid credentials' });
    }
    }
);

export default authController;