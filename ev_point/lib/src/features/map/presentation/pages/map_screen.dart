import 'package:ev_point/src/features/map/domain/entities/station.dart';
import 'package:ev_point/src/features/map/presentation/cubit/station/station_cubit.dart';
import 'package:ev_point/src/features/map/presentation/cubit/station/station_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:geolocator/geolocator.dart' as geo;

import '../widgets/navigator_bar.dart';
import '../widgets/search_header.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  MapboxMap? _map;
  int _tab = 0;
  final _searchCtrl = TextEditingController();
  List<Station> _stations = [];
  bool _loading = true;
  String? error ;

  @override
  void initState() {
    super.initState();
    _ensurePermission();
  }

  Future<bool> _ensurePermission() async {
    final enabled = await geo.Geolocator.isLocationServiceEnabled();
    if (!enabled) {
      return false;
    }

    var permission = await geo.Geolocator.checkPermission();
    if (permission == geo.LocationPermission.denied) {
      permission = await geo.Geolocator.requestPermission();
    }

    if (permission == geo.LocationPermission.deniedForever ||
        permission == geo.LocationPermission.denied) {
      return false;
    }

    return true;
  }

  Future<void> _goToMyLocation() async {
    if (_map == null) return;
    try {
      final pos = await geo.Geolocator.getCurrentPosition(
        desiredAccuracy: geo.LocationAccuracy.high,
      );

      await _map!.location.updateSettings(
        LocationComponentSettings(enabled: true, pulsingEnabled: true),
      );

      await _map!.flyTo(
        CameraOptions(
          center: Point(coordinates: Position(pos.longitude, pos.latitude)),
          zoom: 15,
        ),
        MapAnimationOptions(duration: 800),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Không lấy được vị trí: $e')));
    }
  }

  void _onMapCreated(MapboxMap controller) async {
    _map = controller;

    // Chỉ bay tới vị trí khi đã có quyền
    final ok = await _ensurePermission();
    if (ok) _goToMyLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          MapWidget(
            key: const ValueKey("map"),
            styleUri: MapboxStyles.MAPBOX_STREETS,
            cameraOptions: CameraOptions(
              center: Point(
                coordinates: Position(106.7004, 10.7769),
              ), // fallback: HCM
              zoom: 12,
            ),
            onMapCreated: _onMapCreated,
          ),

          //search header
          Positioned(
            left: 0,
            right: 0,
            top: 20,
            child: SearchHeader(
              controller: _searchCtrl,
              onChanged: (val) {
                // TODO: filter stations theo val
              },
              onFilterTap: () {
                // TODO: mở bottom sheet hoặc popup filter
              },
            ),
          ),


          /// Nút recenter
          Positioned(
            bottom: 100,
            right: 16,
            child: FloatingActionButton(
              onPressed: _goToMyLocation,
              child: const Icon(Icons.my_location),
            ),
          ),

          //Navigator bar
          Positioned(
            left: 0, right: 0, bottom: 0,
            child: NavigatorBar(
              currentIndex: _tab,
              onTap: (i) => setState(() => _tab = i),
            ),
          ),


        ],
      ),
    );
  }
}
