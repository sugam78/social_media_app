const express = require("express");
const mongoose = require("mongoose");
const authRouter = require("./Routes/auth.js");
const postRouter = require("./Routes/post.js");
const friendRouter = require("./Routes/friends.js");


const app = express();
const PORT = 3000;
const DB = "mongodb+srv://paudelsugam9:sugam456@cluster0.qlftvii.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0";

//middlewares
app.use(express.json());
app.use(authRouter);
app.use(postRouter);
app.use(friendRouter);

mongoose.connect(DB).then(()=>{
    console.log("Connection Success");
}).catch((e)=>{
    console.log(e);
});

app.listen(PORT,"0.0.0.0",()=>{
    console.log(`connected to port ${PORT}`);
});