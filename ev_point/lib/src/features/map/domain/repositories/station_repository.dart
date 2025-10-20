import '../entities/station.dart';

abstract class StationRepository {
  Future<List<Station>> getStations();
}