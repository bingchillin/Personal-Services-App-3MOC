import { NextFunction, Request, Response } from "express";
import { Role } from "../Users/Model";


const generateAuthMiddleware =  (
    allowedRoles: Role[]
    ) => {
    return (
        req: Request,
        res: Response,
        next: NextFunction
        ) => {
        const currentRole: Role = req.jwt.payload.role

        if (!allowedRoles.includes(currentRole)) {
            res.status(401).send({
                status: 401,
                message: "You cannot access this resource."
            })
        } else {
            next();
        }

    }
}

export default generateAuthMiddleware;