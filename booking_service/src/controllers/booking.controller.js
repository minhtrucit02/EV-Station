import Booking from "../models/booking.model.js";
import { BookingService } from "../service/booking_service.js";


// Create a new booking
export async function createBooking(req, res) {
    return BookingService.createBooking(req, res);
}

// Get all bookings
export async function getAllBookings(req, res) {
    try {
        const bookings = await Booking.findAll();
        if (!bookings || bookings.length == 0) {
            return res.status(404).json({ message: "No bookings found", data: [] });
        }
        return res.status(200).json({ message: "Bookings fetched successfully", count: bookings.length, data: bookings });
    } catch (error) {
        console.error("Error fetching bookings:", error);
        return res.status(500).json({ message: "Internal server error" });
    }
}

