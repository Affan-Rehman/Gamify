
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:gamify/jumper/ui/game_over_menu.dart';
import 'package:gamify/jumper/ui/pause_menu.dart';

import 'my_game.dart';

class MyGameWidget extends StatelessWidget {
  const MyGameWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GameWidget(
      game: MyGame(),
      overlayBuilderMap: {
        'GameOverMenu': (context, MyGame game) {
          return GameOverMenu(game: game);
        },
        'PauseMenu': (context, MyGame game) {
          return PauseMenu(game: game);
        }
      },
    );
  }
}
