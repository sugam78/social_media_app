const mongoose = require("mongoose");
const postSchema = require("../Models/post");

const userSchema = mongoose.Schema({
    name:{
        required: true,
        type: String,
        trim: true
    },
    email:{
            required: true,
            type: String,
            trim: true,
            validate: {
                validator: (value)=>{
                    const re = /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
                    return value.match(re);
                },
                message: 'Please enter a valid email address',
            }
        },
        password: {
            required: true,
            type: String,
            validate: {
                validator: (value)=>{
                    return value.length > 6;
                },
                message: 'Please enter a valid password',
            }
        },
        image:{
            type: String,
            require: false,
        },
        friends:[{
            type: String,
                required: false,
                trim: true,
        }],
        sentFriendRequests:[{
            type: String,
                required: false,
                trim: true,
        }],
        receivedFriendRequests:[{
            type: String,
                required: false,
                trim: true,
        }],
        posts: [postSchema],
});

const user = mongoose.model('user', userSchema);
module.exports = user;