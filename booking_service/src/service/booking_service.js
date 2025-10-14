import Booking from "../models/booking.model.js";

export const BookingService = {
    async createBooking(req, res) {
        try {
            const user_id = req.body.user_id || req.query.user_id;
            const point_id = req.body.point_id || req.query.point_id;
            const schedule_start_time = req.body.schedule_start_time || req.query.schedule_start_time;

            if (user_id == null) {
                return res.status(400).json({ message: "User need to login" });
            }
            let finalStartTime;
            if (/^\d{2}:\d{2}$/.test(schedule_start_time)) {
                const today = new Date();
                const [hours, minutes] = schedule_start_time.split(':');
                today.setHours(parseInt(hours, 10), parseInt(minutes, 10), 0, 0);
                finalStartTime = today;
            }
            else {
                finalStartTime = new Date(schedule_start_time);
            }
            const booking = await Booking.create({
                user_id,
                point_id,
                schedule_start_time: finalStartTime,
            });
            return res.status(201).json({ message: "Booking created successfully", data: booking });
        } catch (error) {
            console.error("Error creating booking:", error);
            return res.status(500).json({ message: "Internal server error" });
        }
    },


    async getAllBookings() {
        try {
            const bookings = await Booking.findAll();
            if (!bookings || bookings.length === 0) {
                return { status: 404, message: "No bookings found", data: [] };
            }
            return { status: 200, message: "Bookings fetched successfully", count: bookings.length, data: bookings };
        } catch (error) {
            console.error("Error fetching bookings:", error);
            return { status: 500, message: "Internal server error" };
        }
    },


    async getBookingById(id) {
        try {
            const booking = await Booking.findByPk(id);
            if (!booking) {
                return { status: 404, message: "Booking not found" };
            }
            return { status: 200, message: "Booking fetched successfully", data: booking };
        } catch (error) {
            console.error("Error fetching booking by ID:", error);
            return { status: 500, message: "Internal server error" };
        }

    }
};
