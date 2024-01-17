import 'dart:math';

import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame_forge2d/flame_forge2d.dart' as w;
import 'package:flutter/material.dart';
import 'package:gamify/jumper/assets.dart';
import 'package:gamify/jumper/high_scores.dart';
import 'package:gamify/jumper/objects/bullet.dart';
import 'package:gamify/jumper/objects/cloud_enemy.dart';
import 'package:gamify/jumper/objects/coin.dart';
import 'package:gamify/jumper/objects/floor.dart';
import 'package:gamify/jumper/objects/hearth_enemy.dart';
import 'package:gamify/jumper/objects/hero.dart';
import 'package:gamify/jumper/objects/platform.dart';
import 'package:gamify/jumper/objects/platform_pieces.dart';
import 'package:gamify/jumper/objects/power_up.dart';
import 'package:gamify/jumper/ui/game_ui.dart';

final screenSize = Vector2(428, 926);
final worldSize = Vector2(4.28, 9.26);

final random = Random();

enum GameState {
  running,
  gameOver,
}

late MyHero hero;

class MyGame extends Forge2DGame
    with HasKeyboardHandlerComponents, TapDetector {
  int score = 0;
  int coins = 0;
  int bullets = 0;
  double generatedWorldHeight = 6.7;
  var state = GameState.running;

  // Scale the screenSize by 100 and set the gravity of 15
  MyGame() : super(zoom: 100, gravity: Vector2(0, 9.8));

  @override
  Future<void> onLoad() async {
    camera.viewport = FixedResolutionViewport(screenSize);

    final background = SpriteComponent(
      sprite: Assets.background,
      size: screenSize,
    );
    background.anchor = Anchor.topLeft;

    // Adds a black background to the viewport
    add(background);

    add(GameUI());

    add(Floor());
    hero = MyHero();

    // generateNextSectionOfWorld();
    await add(hero);

    final worldBounds =
        Rect.fromLTRB(0, -double.infinity, worldSize.x, worldSize.y);

    // Specify the World class from forge2d
    camera.followBodyComponent(hero,
        worldBounds: worldBounds, world: World.withGravity(Vector2(0, -10.0)));
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (state == GameState.running) {
      if (generatedWorldHeight > hero.body.position.y - worldSize.y / 2) {
        generateNextSectionOfWorld();
      }
      final heroY = (hero.body.position.y - worldSize.y) * -1;

      if (score < heroY) {
        score = heroY.toInt();
      }

      if (score - 7 > heroY) {
        hero.hit();
      }

      if (hero.state == HeroState.dead) {
        state = GameState.gameOver;
        HighScores.saveNewScore(score);
        overlays.add('GameOverMenu');
      }
    }
  }

  bool isOutOfScreen(Vector2 position) {
    final heroY = (hero.body.position.y - worldSize.y) * -1;
    final otherY = (position.y - worldSize.y) * -1;

    return otherY < heroY - worldSize.y / 2;
  }

  void generateNextSectionOfWorld() {
    for (int i = 0; i < 10; i++) {
      add(Platform(
        x: worldSize.x * random.nextDouble(),
        y: generatedWorldHeight,
      ));
      add(Platform(
        x: worldSize.x * random.nextDouble(),
        y: generatedWorldHeight,
      ));

      if (random.nextBool()) {
        add(HearthEnemy(
          x: worldSize.x * random.nextDouble(),
          y: generatedWorldHeight - 1.5,
        ));
      } else if (random.nextDouble() < .2) {
        add(CloudEnemy(
          x: worldSize.x * random.nextDouble(),
          y: generatedWorldHeight - 1.5,
        ));
      }

      if (random.nextDouble() < .3) {
        add(PowerUp(
          x: worldSize.x * random.nextDouble(),
          y: generatedWorldHeight - 1.5,
        ));
        if (random.nextDouble() < .2) {
          addCoins();
        }
      }

      generatedWorldHeight -= 2.7;
    }
  }

  void addBrokenPlatformPieces(Platform platform) {
    final x = platform.body.position.x;
    final y = platform.body.position.y;

    final leftSide = PlatformPieces(
      x: x - (PlatformPieces.size.x / 2),
      y: y,
      isLeftSide: true,
      type: platform.type,
    );

    final rightSide = PlatformPieces(
      x: x + (PlatformPieces.size.x / 2),
      y: y,
      isLeftSide: false,
      type: platform.type,
    );

    add(leftSide);
    add(rightSide);
  }

  void addCoins() {
    final rows = random.nextInt(15) + 1;
    final cols = random.nextInt(5) + 1;

    final x = (worldSize.x - (Coin.size.x * cols)) * random.nextDouble() +
        Coin.size.x / 2;

    for (int col = 0; col < cols; col++) {
      for (int row = 0; row <= rows; row++) {
        add(Coin(
          x: x + (col * Coin.size.x),
          y: generatedWorldHeight + (row * Coin.size.y) - 2,
        ));
      }
    }
  }

  void addBullets() {
    bullets -= 3;
    if (bullets < 0) bullets = 0;
    if (bullets == 0) return;
    final x = hero.body.position.x;
    final y = hero.body.position.y;

    add(Bullet(x: x, y: y, accelX: -1.5));
    add(Bullet(x: x, y: y, accelX: 0));
    add(Bullet(x: x, y: y, accelX: 1.5));
  }
}
