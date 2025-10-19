import 'package:ev_point/src/features/booking/presentations/booking_home_screen.dart';
import 'package:ev_point/src/features/splash_screen/presentations/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  MapboxOptions.setAccessToken(dotenv.env["MAPBOX_ACCESS_TOKEN"]!);
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Flutter Demo', home: BookingHomeScreen());
  }
}
