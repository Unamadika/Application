import express from 'express';
import cors from 'cors';
import dotenv from 'dotenv';
import { connectDB } from './src/configs/db.js';
import authRoutes from './src/routes/authRoutes.js';
import trekRoutes from './src/routes/trekRoutes.js';
import bookingRoutes from "./src/routes/bookingRoutes.js";

dotenv.config();

const app = express();

// Get frontend URL from environment or use default
const FRONTEND_URL = process.env.FRONTEND_URL || 'http://localhost:3000';
const LOCAL_IP = '192.168.1.70';

// CORS configuration - Allow ALL for development
app.use(cors());

// Log all requests for debugging
app.use((req, res, next) => {
    console.log(`[${new Date().toISOString()}] ${req.method} ${req.url} - Origin: ${req.headers.origin}`);
    next();
});

// Body parser middleware
app.use(express.json());

// Routes
app.use('/api/auth', authRoutes);
app.use('/api/treks', trekRoutes);
app.use("/api/bookings", bookingRoutes);

// Health check endpoint
app.get('/api/health', (req, res) => {
    res.json({ status: 'ok', message: 'Sahara Travel API is running' });
});

// Global error handler middleware (must have 4 parameters)
app.use((err, req, res, next) => {
    console.error('Error:', err);
    if (err.message === 'Not allowed by CORS') {
        return res.status(403).json({
            message: 'CORS error: Origin not allowed',
            origin: req.headers.origin
        });
    }
    res.status(err.status || 500).json({
        message: err.message || 'Internal server error'
    });
});

// 404 handler
app.use((req, res) => {
    res.status(404).json({ message: 'Route not found' });
});

// Connect to database
connectDB();

const PORT = process.env.PORT || 6000;
app.listen(PORT, () => {
    console.log(`Server running on port ${PORT}`);
    console.log(`Health check: http://localhost:${PORT}/api/health`);
    console.log(`Frontend URL: ${FRONTEND_URL}`);
    console.log(`Local IP: http://${LOCAL_IP}:${PORT}`);
    console.log(`API Base URL: http://${LOCAL_IP}:${PORT}/api`);
});
