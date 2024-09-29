const express = require('express');
const multer = require('multer');
const mongoose = require('mongoose');
const path = require('path');
const app = express();

// Connect to MongoDB (replace with your MongoDB URI)
mongoose.connect('mongodb://localhost:27017/image_upload_db', {
    useNewUrlParser: true,
    useUnifiedTopology: true
});

// Define a schema to store image data
const imageSchema = new mongoose.Schema({
    imagePath: String
});
const Image = mongoose.model('Image', imageSchema);

// Configure Multer for file storage
const storage = multer.diskStorage({
    destination: (req, file, cb) => {
        cb(null, 'uploads/');
    },
    filename: (req, file, cb) => {
        cb(null, Date.now() + path.extname(file.originalname)); // Save file with timestamp
    }
});
const upload = multer({ storage: storage });

// Serve static files
app.use('/uploads', express.static('uploads'));

// POST route to handle image upload
app.post('/upload', upload.single('image'), (req, res) => {
    const newImage = new Image({
        imagePath: req.file.path
    });
    
    newImage.save()
        .then(() => {
            res.json({ message: 'Image uploaded successfully!' });
        })
        .catch(err => {
            console.error(err);
            res.status(500).json({ message: 'Error uploading image' });
        });
});

// Start server
app.listen(3000, () => {
    console.log('Server is running on http://localhost:3000');
});
