import express = require("express");


const app = express();


app.get("/home",  (req, res) => {
    console.log("Hello World");
    res.send({"hello": "world"});
});

app.listen(5000, ()=>{
    console.log("Started Listening");
});