import '../../domain/entities/station.dart';
import '../../domain/repositories/station_repository.dart';
import '../datasources/station_remote_datasource.dart';

class StationRepositoryImpl implements StationRepository {
  final StationRemoteDataSource remote;
  StationRepositoryImpl(this.remote);

  @override
  Future<List<Station>> getStations() => remote.fetchStations();
}
