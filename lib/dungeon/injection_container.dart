import 'game/features/player/bloc/health/health_bloc.dart';
import 'game/features/points/bloc/score/score_bloc.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

void init() {
  if (!sl.isRegistered<ScoreBloc>()) {
    sl.registerSingleton<ScoreBloc>(ScoreBloc());
  }

  // Check if HealthBloc is not already registered before registering it
  if (!sl.isRegistered<HealthBloc>()) {
    sl.registerSingleton<HealthBloc>(HealthBloc());
  }
}
