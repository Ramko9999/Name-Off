import express = require("express");
import DB from "../core/DB";
import crypto from "crypto";

const userRouter = express.Router();

type UserCreation = {
    username:string
}

userRouter.post("/create", (req, res) => {
    const {username}:UserCreation = req.body;
    if(username === "" || username.length < 8){
        res.status(400).send("Username is invalid");
    }
    const userId = crypto.randomBytes(12).toString("hex");
    const queryText = "INSERT INTO GAME_USER(id, username, games_played) VALUES ($1, $2, $3)";
    const queryValues = [userId, username, 0];

    DB.query(queryText, queryValues, (err, result)=>{
        if(err){
            console.log(err.stack);
            res.status(500);
        }
        else{
            const user = {"id": userId, "username": username, "games_played": 0};
            res.status(200).send(user);
        }
    });
});

userRouter.get("/:id", (req, res) => {
    if(!("id" in req.params) || req.params.id === ""){
        res.status(400).send("Id is invalid");
    }
    const {id} = req.params;
    const queryText = "SELECT * FROM GAME_USER WHERE id=$1";
    const queryValues = [id];
    DB.query(queryText, queryValues, (err, result) => {
        if(err){
            console.log(err.stack);
            res.status(500);
        }
        else{
            if(result.rows.length === 0){
                res.status(404).send("The user you are looking for doesn't exist.");
            }
            else{
                const user = result.rows[0];
                res.status(200).send(user);
            }
        }
    });
});



export default userRouter;