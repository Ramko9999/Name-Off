import express = require("express");
import userRouter from "../routes/User";
import gameRouter from "../routes/Game";
import {Server} from "http";



const app = express();
app.use(express.json());
app.use("/user", userRouter);
app.use("/game", gameRouter);

const httpServer = new Server(app);

export {httpServer};