import { Role } from "../../Users/Model";

export default interface AuthDTO{
    username: string,
    role: Role
}