const express = require("express");
const friendRouter = express.Router();
const User = require("../Models/user");
const auth = require("../Middleware/auth");

friendRouter.post("/api/send-friend-request",auth,async(req,res)=>{
try{
    const {senderId,receiverId} = req.body;
    const sender = await User.findById(senderId);
    const receiver = await User.findById(receiverId);
    if(!receiver){
        return res.status(401).json({msg: "User not found" });
    }
    await sender.sentFriendRequests.push(receiverId);
    await receiver.receivedFriendRequests.push(senderId);
    await sender.save();
    await receiver.save();
    res.json({msg: "Friend Request Sent"});
}
catch(err){
    res.status(500).json({msg:err.message});
}
});

friendRouter.post("/api/remove-friend-request",auth,async(req,res)=>{
try{
    const {senderId,receiverId} = req.body;
    const sender = await User.findById(senderId);
    const receiver =await User.findById(receiverId);
    if(!receiver){
        return res.status(401).json({msg: "User not found" });
    }
    await sender.sentFriendRequests.pull(receiverId);
    await receiver.receivedFriendRequests.pull(senderId);
    await sender.save();
    await receiver.save();
    res.json({msg: "Cancelled sent request"});
}
catch(err){
    res.status(500).json({msg:err.message});
}
});

friendRouter.get("/api/get-stranger-users",auth,async(req,res)=>{
    try{
        const currentUserId = req.header("id");
        const currentUser = await User.findById(currentUserId);
        const excludeIds = [currentUserId,...currentUser.friends,...currentUser.sentFriendRequests,...currentUser.receivedFriendRequests];
        const users =await User.find({_id: { $nin: excludeIds }});
        res.json(users);
    }
    catch(err){
        res.status(500).json({msg:err.message});
    }
});

friendRouter.get("/api/get-friend-requests", async (req, res) => {
    try {
        const currentUserId = req.header("id");
        const currentUser = await User.findById(currentUserId).lean();
        const includeIds = [...currentUser.receivedFriendRequests];
        const users = await User.find({ _id: { $in: includeIds } }).lean();
        res.json(users);
    } catch (err) {
        res.status(500).json({ msg: err.message });
    }
});


friendRouter.post("/api/confirm-friend-request",async(req,res)=>{
    try {
         const {senderId,receiverId} = req.body;
         const sender = await User.findById(senderId);
         const receiver =await User.findById(receiverId);
         await sender.friends.push(receiverId);
         await sender.sentFriendRequests.pull(receiverId);
         await receiver.friends.push(senderId);
         await receiver.receivedFriendRequests.pull(senderId);
         await sender.save();
         await receiver.save();
        } catch (err) {
            res.status(500).json({ msg: err.message });
        }
});

friendRouter.get("/api/get-friends",async(req,res)=>{
try {
        const currentUserId = req.header("id");
        const currentUser = await User.findById(currentUserId).lean();
        const includeIds = [...currentUser.friends];
        const users = await User.find({ _id: { $in: includeIds } }).lean();
        res.json(users);
    } catch (err) {
            res.status(500).json({ msg: err.message });
        }
});


module.exports = friendRouter;