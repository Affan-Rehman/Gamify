import 'package:flame_audio/flame_audio.dart';

class DinoSounds {
  static Future start() async {
    FlameAudio.bgm.initialize();

    await FlameAudio.audioCache
        .loadAll(['jumper_fall.wav', 'jumper_level.mp3']);
  }

  static void fall() {
    FlameAudio.play('jumper_fall.wav');
  }

  static void jumper() {
    FlameAudio.bgm.play('jumper_level.mp3');
  }

  static void stopJumper() {
    FlameAudio.bgm.stop();
  }
}
