import express = require("express");
import crypto from "crypto";
import {gameManager} from "../core/SocketHandler";
import {Game} from "../core/Game";

const gameRouter = express.Router();

gameRouter.post("/create", (req, res) => {
    const gameId = crypto.randomBytes(10).toString("hex");
    res.send({id: gameId});
});

gameRouter.get("/:id", (req, res) => {
    if(!("id" in req.params)){
        res.status(400).send("Id is not provided");
    }

    const gameId: string = req.params.id;
    if(!gameManager.has(gameId)){
        res.status(404).send("The game you are looking for doesn't exist");
    }

    const game = gameManager.get(gameId);
    res.status(200).send(game);
});

gameRouter.get("/bulk/all", (req, res) => {
    const games: Game[] = [];
    gameManager.forEach((game) => {
        games.push(game.serialize());
    });
    res.status(200).send(games);
});


export default gameRouter;





