import Joi, { ValidationError, ValidationErrorItem } from 'joi';
import NotFoundError from '../errors/NotFoundError';
import IRepository from '../interfaces/IRepository'
import idService from '../services/idService';
import User  from '../Users/Model';
import createReservationDTO from './dto/createReservation.dto';
import updateReservationDto from './dto/updateReservation.dto';
import Reservation, { IReservation, ReservationValidationSchema } from './Model';


type TReservation = typeof Reservation;

export class ReservationsRepository implements IRepository<IReservation, createReservationDTO> {

    async getAll(): Promise<IReservation[]> {
        return await Reservation.find();
    }

    async getOne(id: string): Promise<IReservation | null> {
        return await Reservation.findById(id);
    }

    async deleteOne(id: string): Promise<boolean> {
        const result = await Reservation.findByIdAndDelete(id);
        if (!result) {
            return false;
        }

        return true;
    }

    async createOne(object: createReservationDTO): Promise<null | ValidationErrorItem[]> {

        // TODO: calculate price

        const reservation = new Reservation({
            object
        })

        if (object.dateStart > object.dateEnd
            || object.dateStart < new Date()) {
            throw Error("Invalid reservation Date.")
        }


        const validationResult = ReservationValidationSchema.validate(object)

        if (validationResult.error) {
            return validationResult.error.details
        }

        await reservation.save();

        return null;

    }

    async updateOne(id: string, updateDTO: updateReservationDto): Promise<void | ValidationError> {
        const newReservation = await Reservation.findByIdAndUpdate(id, updateDTO, { new: true })
        
        if (newReservation === null) {
            throw new NotFoundError("No reservation with this ID.")
        }
        const validateResult = ReservationValidationSchema.validate(newReservation);

        if (validateResult.error) {
            return validateResult.error
        }
    }
}

export default new ReservationsRepository();