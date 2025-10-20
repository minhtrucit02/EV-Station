// lib/src/features/map/data/datasources/station_remote_datasource.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/station_model.dart';

abstract class StationRemoteDataSource {
  Future<List<StationModel>> fetchStations();
}

class StationRemoteDataSourceImpl implements StationRemoteDataSource {
  final http.Client client;
  final String baseUrl;
  StationRemoteDataSourceImpl(this.client, this.baseUrl);

  @override
  Future<List<StationModel>> fetchStations() async {
    final res = await client.get(Uri.parse('$baseUrl/api/v1/stations'));
    if (res.statusCode != 200) throw Exception('HTTP ${res.statusCode}');
    final data = jsonDecode(res.body) as Map<String, dynamic>;
    return (data['stations'] as List)
        .map((e) => StationModel.fromJson(e))
        .toList();
  }
}
