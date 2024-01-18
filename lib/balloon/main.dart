import 'package:flame_audio/flame_audio.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';

import 'game/balloon_pop.dart';
import 'light_theme.dart';
import 'overlays/exit_overlay.dart';
import 'overlays/game_over_overlay.dart';
import 'overlays/game_overlay.dart';
import 'overlays/settings_overlay.dart';
import 'overlays/instructions_overlay.dart';
import 'overlays/main_menu_overlay.dart';
import 'overlays/pause_overlay.dart';

// getting reference to Flame game
final Game game = BalloonPop();

class BalloonGame extends StatefulWidget {
  const BalloonGame({super.key});

  @override
  State<BalloonGame> createState() => _HomePageState();
}

class _HomePageState extends State<BalloonGame> with WidgetsBindingObserver {
  // App life cycle for preventing things from continuing while app is "paused" or minimized
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    switch (state) {
      case AppLifecycleState.resumed:
        if (!game.paused) game.resumeEngine();
        break;
      case AppLifecycleState.hidden:
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
        game.pauseEngine();
        break;
      case AppLifecycleState.detached:
        game.pauseEngine();
        break;
    }
  }

  @override
  void dispose() {
    FlameAudio.bgm.stop();
    super.dispose();
  }

  // add this as an observer to WidgetsBinding so that AppLifecycleState can be monitored
  @override
  void initState() {
    super.initState();
    FlameAudio.bgm.resume();
    WidgetsBinding.instance.addObserver(this);
  }

  // building app page
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Container(
              constraints: const BoxConstraints(
                maxWidth: 800,
                minWidth: 550,
              ),
              // game lives inside this scaffold, rather than the whole app being just the GameWidget
              child: GameWidget(
                game: game,
                overlayBuilderMap: <String,
                    Widget Function(BuildContext, Game)>{
                  // UI menu
                  'gameOverlay': (context, game) => GameOverlay(game),

                  // Main Menu
                  'mainMenuOverlay': (context, game) => MainMenuOverlay(game),

                  // Settings
                  'settingsOverlay': (context, game) => SettingsOverlay(game),

                  // Instructions
                  'instructionsOverlay': (context, game) =>
                      InstructionsOverlay(game),

                  // Game Over Screen
                  'gameOverOverlay': (context, game) => GameOverOverlay(game),

                  // Pause Screen
                  'pauseOverlay': (context, game) => PauseOverlay(game),

                  // Exit Screen (when pressing back button on Main Menu)
                  'exitOverlay': (context, game) => ExitOverlay(game),
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
