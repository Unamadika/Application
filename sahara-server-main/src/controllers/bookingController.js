import Booking from "../models/bookingModel.js";
import Trek from "../models/trekModel.js";

// Create Booking
export const createBooking = async (req, res) => {
  try {
    const { trekId, numberOfPeople, trekDate } = req.body;

    const trek = await Trek.findById(trekId);
    if (!trek)
      return res.status(404).json({ message: "Trek not found" });

    const totalPrice = trek.price * numberOfPeople;

    const booking = await Booking.create({
      user: req.user._id,
      trek: trekId,
      numberOfPeople,
      totalPrice,
      trekDate
    });

    res.status(201).json(booking);
  } catch (error) {
    res.status(400).json({ message: error.message });
  }
};

// Get all bookings of logged-in user
export const getMyBookings = async (req, res) => {
  try {
    const bookings = await Booking.find({ user: req.user._id })
      .populate("trek", "name location price")
      .sort({ createdAt: -1 });

    res.json(bookings);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

// Get a single booking
export const getBookingById = async (req, res) => {
  try {
    const booking = await Booking.findById(req.params.id)
      .populate("trek")
      .populate("user", "name email");

    if (!booking)
      return res.status(404).json({ message: "Booking not found" });

    res.json(booking);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

// Cancel Booking
export const cancelBooking = async (req, res) => {
  try {
    const booking = await Booking.findById(req.params.id);

    if (!booking)
      return res.status(404).json({ message: "Booking not found" });

    // Only the owner can cancel
    if (booking.user.toString() !== req.user._id.toString())
      return res.status(403).json({ message: "Unauthorized user" });

    booking.status = "Cancelled";
    await booking.save();

    res.json({ message: "Booking cancelled successfully" });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};
