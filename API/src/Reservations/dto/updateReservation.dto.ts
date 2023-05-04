export default interface updateReservationDto{
    dateStart?: Date;
    dateEnd?: Date;
    price?: number;
    cancelled?: boolean;
    roomId?: string;
}