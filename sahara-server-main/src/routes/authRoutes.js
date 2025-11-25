import express from 'express';
import { registerUser, loginUser, getProfile, listGuides } from '../controllers/authController.js';
import { protect } from '../middleware/authMiddleware.js';

const router = express.Router();

router.post('/register', registerUser);
router.post('/login', loginUser);
router.get('/profile', protect, getProfile);
router.get('/guides', listGuides);

export default router;
