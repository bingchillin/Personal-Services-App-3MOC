import { ValidationError, ValidationErrorItem } from 'joi';
import NotFoundError from '../errors/NotFoundError';
import IRepository from '../interfaces/IRepository'
import User, { IUser, UserValidationSchema } from './Model';

export class UsersRepository implements IRepository<IUser, IUser> {

    async getAll(): Promise<IUser[]> {
        return await User.find();
    }

    async getOne(id: string): Promise<IUser | null> {
        return await User.findById(id);
    }

    async getOneByUsername(username: string): Promise<IUser | null> {
        const user = await User.findOne({ username });

        return user;
    }

    async deleteOne(id: string): Promise<boolean> {
        const user = await User.findByIdAndDelete(id);

        if (!user) {
            return false;
        }

        return true;
    }

    async createOne(object: IUser): Promise<null | ValidationErrorItem[]> {


        const validationResult = UserValidationSchema.validate(object)

        if (validationResult.error) {
            return validationResult.error.details
        }

        const user = new User(object);

        await user.save();

        return null;

    }
}

export default new UsersRepository();