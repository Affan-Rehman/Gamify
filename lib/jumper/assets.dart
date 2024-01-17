import 'package:flame/components.dart';

bool loadedAssets = false;
class Assets {
  static late final Sprite button;
  static late final Sprite buttonBack;

  static late final Sprite background;

  static late final Sprite heroFall;
  static late final Sprite heroJump;

  static late final Sprite cloudHappyEnemy;
  static late final Sprite cloudAngryEnemy;
  static late final SpriteAnimation hearthEnemy;
  static late final SpriteAnimation jetpackFire;
  static late final SpriteAnimation lightning;

  static late final Sprite coin;
  static late final Sprite gun;
  static late final Sprite bullet;
  static late final Sprite spring;
  static late final Sprite bubbleSmall;
  static late final Sprite jetpackSmall;
  static late final Sprite bubble;
  static late final Sprite jetpack;

  static late final Sprite platformBeige;
  static late final Sprite platformBeigeLight;
  static late final Sprite platformBeigeBroken;
  static late final Sprite platformBeigeLeft;
  static late final Sprite platformBeigeRight;
  static late final Sprite platformBlue;
  static late final Sprite platformBlueLight;
  static late final Sprite platformBlueBroken;
  static late final Sprite platformBlueLeft;
  static late final Sprite platformBlueRight;
  static late final Sprite platformGray;
  static late final Sprite platformGrayLight;
  static late final Sprite platformGrayBroken;
  static late final Sprite platformGrayLeft;
  static late final Sprite platformGrayRight;
  static late final Sprite platformGreen;
  static late final Sprite platformGreenLight;
  static late final Sprite platformGreenBroken;
  static late final Sprite platformGreenLeft;
  static late final Sprite platformGreenRight;
  static late final Sprite platformMulticolor;
  static late final Sprite platformMulticolorLight;
  static late final Sprite platformMulticolorBroken;
  static late final Sprite platformMulticolorLeft;
  static late final Sprite platformMulticolorRight;
  static late final Sprite platformPink;
  static late final Sprite platformPinkLight;
  static late final Sprite platformPinkBroken;
  static late final Sprite platformPinkLeft;
  static late final Sprite platformPinkRight;
  static Future<void> load() async {
    button = await Sprite.load("button.png");
    buttonBack = await Sprite.load("buttonback.png");
    background = await Sprite.load("background.png");

    heroFall = await Sprite.load("herofall.png");
    heroJump = await Sprite.load("herojump.png");

    cloudHappyEnemy = await Sprite.load("happycloud.png");
    cloudAngryEnemy = await Sprite.load("angrycloud.png");
    final enemy1 = await Sprite.load("heartenemy1.png");
    final enemy2 = await Sprite.load("heartenemy2.png");
    final lightning1 = await Sprite.load("lightning1.png");
    final lightning2 = await Sprite.load("lightning2.png");

    hearthEnemy = SpriteAnimation.spriteList([
      enemy1,
      enemy2,
    ], stepTime: 0.2, loop: true);

    lightning = SpriteAnimation.spriteList([
      lightning1,
      lightning2,
    ], stepTime: 0.15, loop: true);

    coin = await Sprite.load("coin.png");
    gun = await Sprite.load("pistol.png");
    bullet = await Sprite.load("bullet.png");
    spring = await Sprite.load("spring.png");
    bubbleSmall = await Sprite.load("bubblesmall.png");
    jetpackSmall = await Sprite.load("jetpacksmall.png");
    bubble = await Sprite.load("bubblebig.png");
    jetpack = await Sprite.load("jetpackbig.png");

    final jetpack1 = await Sprite.load("jetfire1.png");
    final jetpack2 =await Sprite.load("jetfire2.png");

    jetpackFire = SpriteAnimation.spriteList([
      jetpack1,
      jetpack2,
    ], stepTime: 0.15, loop: true);

    platformBeige = await Sprite.load("fullbeige.png");
    platformBeigeLight = await Sprite.load("fullbeige.png");
    platformBeigeBroken = await Sprite.load("brokenbeige.png");
    platformBeigeLeft = await Sprite.load("halfleftbeige.png");
    platformBeigeRight = await Sprite.load("halfrightbeige.png");

    platformBlue = await Sprite.load("fullblue.png");
    platformBlueLight = await Sprite.load("fullblue.png");
    platformBlueBroken = await Sprite.load("fullblue.png");
    platformBlueLeft = await Sprite.load("halfleftblue.png");
    platformBlueRight = await Sprite.load("halfrightblue.png");

    platformGray = await Sprite.load("fullgrey.png");
    platformGrayLight = await Sprite.load("fullgrey.png");
    platformGrayBroken = await Sprite.load("brokengrey.png");
    platformGrayLeft = await Sprite.load("halfleftgrey.png");
    platformGrayRight = await Sprite.load("halfrightgrey.png");

    platformGreen = await Sprite.load("fullgreen.png");
    platformGreenLight = await Sprite.load("fullgreen.png");
    platformGreenBroken = await Sprite.load("brokengreen.png");
    platformGreenLeft = await Sprite.load("halfleftgreen.png");
    platformGreenRight = await Sprite.load("halfrightgreen.png");


    platformMulticolor = await Sprite.load("fullmulti.png");
    platformMulticolorLight = await Sprite.load("fullmulti.png");
    platformMulticolorBroken = await Sprite.load("brokenmulti.png");
    platformMulticolorLeft = await Sprite.load("halfleftmulti.png");
    platformMulticolorRight = await Sprite.load("halfrightmulti.png");

    platformPink = await Sprite.load("fullpink.png");
    platformPinkLight = await Sprite.load("fullpink.png");
    platformPinkBroken = await Sprite.load("brokenpink.png");
    platformPinkLeft = await Sprite.load("halfleftpink.png");
    platformPinkRight = await Sprite.load("halfrightpink.png");
    loadedAssets = true;
  }
}
