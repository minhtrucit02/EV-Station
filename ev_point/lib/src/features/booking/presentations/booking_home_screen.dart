import 'package:flutter/material.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

class BookingHomeScreen extends StatefulWidget {
  const BookingHomeScreen({super.key});

  @override
  State<BookingHomeScreen> createState() => _BookingHomeScreenState();
}

class _BookingHomeScreenState extends State<BookingHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MapWidget(),
    );
  }
}
