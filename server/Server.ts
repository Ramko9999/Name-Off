import express = require("express");
import userRouter from "./routes/User";


const app = express();
app.use(express.json());


app.use("/user", userRouter);

app.listen(5000, () => {console.log("App is listening!")});



