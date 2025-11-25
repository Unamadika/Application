import Trek from '../models/trekModel.js';

// Create Trek
export const createTrek = async (req, res) => {
    try {
        const trek = await Trek.create(req.body);
        res.status(201).json(trek);
    } catch (error) {
        res.status(400).json({ message: error.message });
    }
};

// Get all Treks
export const getTreks = async (req, res) => {
    try {
        const treks = await Trek.find();
        res.json(treks);
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
};

// Get Trek by ID
export const getTrekById = async (req, res) => {
    try {
        const trek = await Trek.findById(req.params.id);
        if (!trek) return res.status(404).json({ message: "Trek not found" });
        res.json(trek);
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
};

// Update Trek
export const updateTrek = async (req, res) => {
    try {
        const trek = await Trek.findByIdAndUpdate(req.params.id, req.body, {
            new: true,
        });
        if (!trek) return res.status(404).json({ message: "Trek not found" });
        res.json(trek);
    } catch (error) {
        res.status(400).json({ message: error.message });
    }
};

// Delete Trek
export const deleteTrek = async (req, res) => {
    try {
        const trek = await Trek.findByIdAndDelete(req.params.id);
        if (!trek) return res.status(404).json({ message: "Trek not found" });

        res.json({ message: "Trek deleted successfully" });
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
};
