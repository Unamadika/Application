import express from "express";
import {
  createBooking,
  getMyBookings,
  getBookingById,
  cancelBooking
} from "../controllers/bookingController.js";

import { protect } from "../middleware/authMiddleware.js";

const router = express.Router();

// Protected Routes
router.post("/", protect, createBooking); // Create a booking
router.get("/my-bookings", protect, getMyBookings); // User's bookings
router.get("/:id", protect, getBookingById); // Specific booking
router.put("/cancel/:id", protect, cancelBooking); // Cancel booking

export default router;
