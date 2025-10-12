// testBooking.js
import sequelize from './config/mysql.js';
import Booking from './models/mysql/booking.js'; // đường dẫn tuỳ bạn

async function test() {
  try {
    // 1. Kết nối tới MySQL
    await sequelize.authenticate();
    console.log('✅ MySQL connected successfully.');

    // 2. Sync model (tạo bảng nếu chưa có)
    await Booking.sync({ alter: true });
    console.log('✅ Booking table synced.');

    // 3. Tạo dữ liệu test
    // const booking = await Booking.create({
    //   user_id: 1,
    //   point_id: 10,
    //   schedule_start_time: new Date(Date.now() + 60 * 60 * 1000), // sau 1 tiếng
    //   schedule_end_time: new Date(Date.now() + 2 * 60 * 60 * 1000), // sau 2 tiếng
    //   status: 'HELD'
    // });

    // console.log('✅ Booking created:', booking.toJSON());
  } catch (err) {
    console.error('❌ Error:', err);
  } finally {
    await sequelize.close();
  }
}

test();
