import mongoose from 'mongoose';
import { v4 as uuidv4 } from 'uuid';

const ChargingSessionSchema = new mongoose.Schema({
  _id: { type: mongoose.Schema.Types.ObjectId, auto: true },
  externalId: { type: String, default: () => uuidv4(), unique: true },
  userId: { type: Number, required: true, index: true },
  bookingId: { type: Number, required: true, index: true },
  sessionCode: { type: String, required: true, unique: true },
  startTime: { type: Date, required: true },
  endTime: { type: Date },
  durationTime: { type: Number },
  startSocPercent: { type: Number },
  endSocPercent: { type: Number },
  totalKwh: { type: Number },
  totalPrice: { type: Number }
}, {
  timestamps: true
});

ChargingSessionSchema.pre('save', function (next) {
  if (this.startTime && this.endTime) {
    this.durationSec = Math.floor((+this.endTime - +this.startTime) / 1000);
  }
  next();
});

export const ChargingSession = mongoose.model('ChargingSession', ChargingSessionSchema);
