import 'package:ev_point/src/features/map/presentation/cubit/station/station_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecase/get_stations.dart';

class StationCubit extends Cubit<StationState> {
  final GetStations getStations;
  StationCubit(this.getStations) : super(StationState(loading: true));

  Future<void> load() async {
    emit(StationState(loading: true));
    try {
      final list = await getStations();
      emit(StationState(stations: list));
    } catch (e) {
      emit(StationState(error: e.toString()));
    }
  }
}
