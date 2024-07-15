const express = require("express");
const authRouter = express.Router();
const bcryptjs = require("bcryptjs");
const jwt = require("jsonwebtoken");
const User = require("../Models/user");
const auth = require("../Middleware/auth");

authRouter.post("/api/signup",async(req,res)=>{
    try{
        const {name, email, password} = req.body;
        console.log(email);
        const existingUser =await User.findOne({email});
        if(existingUser){
            return res.status(400).json({msg: "User with same email already exists"});
        }
        const hashedPassword = await bcryptjs.hash(password,8);
        let user = new User({name,email,password: hashedPassword});
        user = await user.save();
        res.json(user);
    }
    catch(e){
        res.status(500).json({error: e.message});
    }
});


authRouter.post("/api/signin",async(req,res)=>{
    try{
        const {email,password} = req.body;
        const user = await User.findOne({email});
        if(!user){
            return res.status(400).json({msg: "User with email does not exists"});
        }
        const isMatch = await bcryptjs.compare(password,user.password);
        if(!isMatch){
            return res.status(400).json({msg: "Wrong Password"});
        }
        const token = jwt.sign({id: user._id},"passwordKey");
        res.json({token,...user._doc});
    }
    catch(e){
        res.status(500).json({error: e.message});
    }
});

//check if token is valid or not
authRouter.post("/api/is-token-valid",async(req,res)=>{
    try{
    const token = req.header("x-auth-token");
    if(!token){
        return res.json(false);
    }
    const verify = jwt.verify(token,"passwordKey");
    if(!verify){
        return res.json(false);
    }
    const user = await User.findById(verify.id);
    if(!user){
        return res.json(false);
    }
    return res.json(true);
    }
    catch(e){
        res.status(500).json({error: e.message});
    }
});

//get user data
authRouter.get("/api/get-user-data",auth,async(req,res)=>{
    try{
        const user = await User.findById(req.user);
        res.json({...user._doc,token: req.token});
    }
    catch(e){
        res.status(500).json({error: e.message});
    }
});

module.exports = authRouter;