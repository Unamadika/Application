import jwt from 'jsonwebtoken';
import User from '../models/userModel.js';

// Generate JWT
const generateToken = (id) => {
    return jwt.sign({ id }, process.env.JWT_SECRET, { expiresIn: '30d' });
};

// Format user response to match Flutter AuthUser model
const formatUserResponse = (user, token) => ({
    _id: user._id,
    name: user.name,
    email: user.email,
    role: user.role || 'user',
    phone: user.phone || '',
    bio: user.bio || '',
    avatarUrl: user.avatarUrl || '',
    languages: user.languages || [],
    experienceYears: user.experienceYears || 0,
    specialties: user.specialties || [],
    token: token,
});

// Register User
export const registerUser = async (req, res) => {
    try {
        const { 
            name, 
            email, 
            password, 
            role = 'user', 
            phone = '', 
            bio = '',
            avatarUrl = '',
            languages = [],
            specialties = [],
            experienceYears = 0
        } = req.body;

        const userExists = await User.findOne({ email });

        if (userExists) {
            return res.status(400).json({ message: 'User already exists' });
        }

        // Validate role
        const allowedRoles = ['user', 'guide'];
        const normalizedRole = allowedRoles.includes(role) ? role : 'user';

        const user = await User.create({ 
            name, 
            email, 
            password,
            role: normalizedRole,
            phone: phone || '',
            bio: bio || '',
            avatarUrl: avatarUrl || '',
            languages: Array.isArray(languages) ? languages : [],
            specialties: Array.isArray(specialties) ? specialties : [],
            experienceYears: experienceYears || 0,
        });

        const token = generateToken(user._id);
        res.status(201).json(formatUserResponse(user, token));
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
};

// Login User
export const loginUser = async (req, res) => {
    try {
        const { email, password } = req.body;

        if (!email || !password) {
            return res.status(400).json({ message: 'Email and password are required' });
        }

        const user = await User.findOne({ email });

        if (user && (await user.matchPassword(password))) {
            const token = generateToken(user._id);
            res.json(formatUserResponse(user, token));
        } else {
            res.status(401).json({ message: 'Invalid email or password' });
        }
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
};

// Get user profile (protected)
export const getProfile = async (req, res) => {
    try {
        const user = await User.findById(req.user.id).select('-password');
        if (user) {
            res.json(user);
        } else {
            res.status(404).json({ message: 'User not found' });
        }
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
};

// Get all guides (public)
export const listGuides = async (req, res) => {
    try {
        const guides = await User.find({ role: 'guide' }).select('-password');
        res.json(guides);
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
};
