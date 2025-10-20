import 'package:ev_point/src/features/map/presentation/pages/map_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'features/map/presentation/cubit/station/station_cubit.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) =>GetIt.I<StationCubit>()..load()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'EV Point',
        home: MapScreen(),
      ),
    );
  }
}
