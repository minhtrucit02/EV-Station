import 'package:ev_point/src/features/map/data/datasources/station_remote_datasource.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart' as mb;

import '../../features/map/data/repositories/station_repository_impl.dart';
import '../../features/map/domain/repositories/station_repository.dart';
import '../../features/map/domain/usecase/get_stations.dart';
import '../../features/map/domain/usecase/get_user_location.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  final baseUrl = dotenv.env['API_BASE_URL'] ?? 'http://10.0.2.2:5001';
  sl.registerLazySingleton(() => http.Client());


  //datasource
  sl.registerLazySingleton<StationRemoteDataSource>(
          () => StationRemoteDataSourceImpl(sl(), baseUrl));
  //Repo
  sl.registerLazySingleton<StationRepository>(
          () => StationRepositoryImpl(sl()));

  //usecase
  sl.registerLazySingleton(() => GetStations(sl()));

  sl.registerLazySingleton<GetUserLocation>(() => GetUserLocation());
  //cubit

  //mapbox
  final token = dotenv.env['MAPBOX_ACCESS_TOKEN'];
  if (token != null && token.isNotEmpty) {
    mb.MapboxOptions.setAccessToken(token);
  }
}