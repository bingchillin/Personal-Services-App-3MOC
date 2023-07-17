import Joi from 'joi';

export interface RequeteSub {
    id: number;
    requete: number;
    user: number;
    accepted: boolean
}

export const RequeteSubValidationSchema = Joi.object({
    requete: Joi.number().required(),
    user: Joi.string().required(),
    accepted: Joi.boolean().optional().default(false)
});

export const validateRequeteSub = (requete: RequeteSub): Joi.ValidationResult<RequeteSub> => {
    return RequeteSubValidationSchema.validate(requete, { abortEarly: false });
  };