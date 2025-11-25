import mongoose from 'mongoose';

const trekSchema = new mongoose.Schema({
    name: { type: String, required: true },
    location: { type: String, required: true },
    difficulty: { type: String, enum: ['Easy', 'Moderate', 'Hard'], required: true },
    durationDays: { type: Number, required: true },
    price: { type: Number, required: true },
    description: { type: String },
    imageUrl: { type: String }, // optional
}, { timestamps: true });

const Trek = mongoose.model('Trek', trekSchema);
export default Trek;
