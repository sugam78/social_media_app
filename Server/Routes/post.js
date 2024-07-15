const express = require("express");
const postRouter = express.Router();
const User = require("../Models/user");
const auth = require("../Middleware/auth");

postRouter.post("/api/create-post", auth, async (req, res) => {
    try {
        const { id, post } = req.body;

        const user = await User.findById(id);
        if (!user) {
            return res.status(401).json({msg: "User not found" });
        }
        user.posts.push(post);

        await user.save();

        res.json({user});
    } catch (e) {
        res.status(500).json({ msg: e.message });
    }
});

module.exports = postRouter;
