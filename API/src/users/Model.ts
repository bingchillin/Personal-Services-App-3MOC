import Joi from 'joi';

export interface User {
    id: number;
    email: string;
    password: string;
    lastname: string;
    firstname: string;
    birthdate: Date;
    dateSignIn: Date;
    profession: number;
    role: number;
}

export const UserValidationSchema = Joi.object({
    email: Joi.string().email().required(),
    password: Joi.string().required(),
    lastname: Joi.string().required(),
    firstname: Joi.string().required(),
    birthdate: Joi.date().required(),
    dateSignIn: Joi.date().required(),
    profession: Joi.number().required(),
    role: Joi.number().required()
});

export const validateUser = (user: User): Joi.ValidationResult<User> => {
    return UserValidationSchema.validate(user, { abortEarly: false });
  };