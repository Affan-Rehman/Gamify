import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'game/core/presentation/screens/menu.dart';
import 'game/features/player/bloc/health/health_bloc.dart';
import 'game/features/points/bloc/score/score_bloc.dart';
import 'injection_container.dart';

class DungeonScreen extends StatelessWidget {
  const DungeonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pixel Adventure',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color(0xFF211F30),
      ),
      debugShowCheckedModeBanner: false,
      home: MultiBlocProvider(
        providers: [
          BlocProvider<ScoreBloc>(
            create: (context) => sl<ScoreBloc>(),
          ),
          BlocProvider<HealthBloc>(
            create: (context) => sl<HealthBloc>(),
          ),
        ],
        child: const Menu(),
      ),
    );
  }
}
