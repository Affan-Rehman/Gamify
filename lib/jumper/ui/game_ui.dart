

import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import '../../main.dart';
import '../assets.dart';
import '../my_game.dart';
import '../utils.dart';

final textPaint = TextPaint(
  style: const TextStyle(
    color: Colors.black,
    fontSize: 35,
    fontWeight: FontWeight.w800,
    fontFamily: 'DaveysDoodleface',
  ),
);

    Vector2 screenSizeVector = Vector2(screenSizeActual.width, screenSizeActual.height);
class GameUI extends PositionComponent with HasGameRef<MyGame> {
  // Keep track of the number of bodies in the world.
  final totalBodies =
      TextComponent(position: Vector2(5, 895), textRenderer: textPaint);

  final totalScore = TextComponent(textRenderer: textPaint);

  final totalCoins = TextComponent(textRenderer: textPaint);

  final totalBullets = TextComponent(textRenderer: textPaint);

  final coin = SpriteComponent(sprite: Assets.coin, size: Vector2.all(25));
  final gun = SpriteComponent(sprite: Assets.gun, size: Vector2.all(35));

  // Keep track of the frames per second
  final fps =
      FpsTextComponent(position: Vector2(5, 870), textRenderer: textPaint);

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    positionType = PositionType.viewport;
    position.y = isIOS ? 25 : 0;
    priority = 3;

    final leftButton = ButtonComponent(
      button: RectangleComponent(
        size: Vector2(120, screenSizeVector.y),
        paint: Paint()..color = Colors.transparent,
      ),
      anchor: Anchor.center,
      position: Vector2(50,
          screenSize.y), // Adjust these coordinates as needed
      onPressed: () {
        hero.left();
      },
      onCancelled: () {
        hero.setZero();
      },
    );
    final left2Button = ButtonComponent(
      button: CircleComponent(
        radius: 50,
        paint: Paint()..color = Colors.red,
      ),
      onPressed: () {
        hero.left();
      },
      onCancelled: () {
        hero.setZero();
      },
      anchor: Anchor.center,
      position: Vector2(50, screenSize.y - 120),
    );
    final fireButton = ButtonComponent(
      button: RectangleComponent(
        size: Vector2(90, screenSizeVector.y),
        paint: Paint()..color = Colors.transparent,
      ),
      anchor: Anchor.center,
      position:
          Vector2(screenSizeVector.x/2, screenSizeVector.y), // Adjust these coordinates as needed
      onPressed: () {
        hero.fireBullet();
      },
    );
    final fire2Button = ButtonComponent(
      button: CircleComponent(
        radius: 50,
        paint: Paint()..color = Colors.orange,
      ),
      anchor: Anchor.center,
      position: Vector2(screenSizeVector.x/2, screenSize.y - 120),
      onPressed: () {
        hero.fireBullet();
      },
    );
    final rightButton = ButtonComponent(
      button: RectangleComponent(
        size: Vector2(100, screenSizeVector.y),
        paint: Paint()..color = Colors.transparent,
      ),
      anchor: Anchor.center,
      position: Vector2(screenSize.x - 100,
          screenSizeVector.y), // Adjust these coordinates as needed
      onPressed: () {
        hero.right();
      },
      onCancelled: () {
        hero.setZero();
      },
    );
    final right2Button = ButtonComponent(
      button: CircleComponent(
        radius: 50,
        paint: Paint()..color = Colors.red,
      ),
      anchor: Anchor.center,
      onPressed: () {
        hero.right();
      },
      onCancelled: () {
        hero.setZero();
      },
      position: Vector2(screenSizeVector.x - 60, screenSize.y - 120),
    );
    final fireText = TextComponent(
        text: 'Right',
        textRenderer: textPaint, // Use the textPaint you've defined earlier
        position: Vector2(screenSizeVector.x - 100,
            screenSize.y - 140) // Adjust the position as needed
        );
    final leftText = TextComponent(
      text: 'Left',
      textRenderer: textPaint, // Use the textPaint you've defined earlier
      position: Vector2(20, screenSize.y - 140), // Adjust the position as needed
    );

    final rightText = TextComponent(
      text: 'Fire',
      textRenderer: textPaint, // Use the textPaint you've defined earlier
      position: Vector2(screenSizeVector.x/2 - 20, screenSize.y - 140), // Adjust the position as needed
    );

    add(fireButton);
    add(leftButton);
    add(left2Button);
    add(rightButton);
    add(right2Button);
    add(fire2Button);
    add(leftText);
    add(rightText);
    add(fireText);
    add(coin);
    add(gun);
    add(fps);
    add(totalBodies);
    add(totalScore);
    add(totalCoins);
    add(totalBullets);
  }

  @override
  void update(double dt) {
    super.update(dt);

    totalBodies.text = 'Bodies: ${gameRef.world.bodies.length}';
    totalScore.text = 'Score ${gameRef.score}';
    totalCoins.text = 'x${gameRef.coins}';
    totalBullets.text = 'x${gameRef.bullets}';

    final posX = screenSize.x - totalCoins.size.x;
    totalCoins.position
      ..x = posX - 5
      ..y = 5;
    coin.position
      ..x = posX - 35
      ..y = 12;

    gun.position
      ..x = 5
      ..y = 12;
    totalBullets.position
      ..x = 40
      ..y = 8;

    totalScore.position
      ..x = screenSize.x / 2 - totalScore.size.x / 2
      ..y = 5;
  }
}
