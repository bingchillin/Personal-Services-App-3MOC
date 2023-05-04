import mongoose from "mongoose";
import configService from "./configService";

const mongoUrl = `mongodb://${configService.MONGO_USER
    }:${configService.MONGO_PASSWORD
    }@${configService.MONGO_HOST
    }:${configService.MONGO_PORT
    }/${configService.MONGO_DB
    }`;

mongoose.connect(mongoUrl)


export default mongoose