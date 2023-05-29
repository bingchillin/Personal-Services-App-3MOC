import { type } from "os";
import { UserValidationSchema } from "./Model";
import User from "./Model";


type TUser = typeof User;
export class UsersRepository {
    getAll(): Promise<User[]> {
        throw new Error("Method not implemented.");
    }
    getOne(id: string): Promise<User | null> {
        throw new Error("Method not implemented.");
    }
    getOneByUsername(username: string): Promise<User | null> {
        throw new Error("Method not implemented.");
    }
    deleteOne(id: string): boolean {
        throw new Error("Method not implemented.");
    }
    createOne(object: User): Promise<void | import("joi").ValidationErrorItem[]> {
        throw new Error("Method not implemented.");
    }

}