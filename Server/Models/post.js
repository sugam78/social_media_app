const mongoose = require("mongoose");

const postSchema = mongoose.Schema({
    caption:{
        required: true,
        type: String,
        trim: true
    },
    images:[{
        required: false,
        type: String,
    }],
    date:{
        required: true,
        type: Date,
    }
});


module.exports = postSchema;