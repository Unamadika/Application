import express from 'express';
import {
    createTrek,
    getTreks,
    getTrekById,
    updateTrek,
    deleteTrek
} from '../controllers/trekController.js';

import { protect } from '../middleware/authMiddleware.js';

const router = express.Router();

// Public routes
router.get('/', getTreks);
router.get('/:id', getTrekById);

// Protected routes (admin only if needed)
router.post('/', protect, createTrek);
router.put('/:id', protect, updateTrek);
router.delete('/:id', protect, deleteTrek);

export default router;
