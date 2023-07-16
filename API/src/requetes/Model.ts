import Joi from 'joi';

export interface Requete {
    id: number;
    client: number;
    timer: string;
    type: number;
    title: string;
    slots: number;
    medicalNeed: boolean;
    accepted: boolean;
    done: boolean;
}

export const RequeteValidationSchema = Joi.object({
    client: Joi.number().required(),
    timer: Joi.string().required(),
    type: Joi.number().required(),
    title: Joi.string().required(),
    slots: Joi.number().required(),
    medicalNeed: Joi.boolean().required(),
    accepted: Joi.boolean().required(),
    done: Joi.boolean().required()
});

export const validateRequete = (requete: Requete): Joi.ValidationResult<Requete> => {
    return RequeteValidationSchema.validate(requete, { abortEarly: false });
  };