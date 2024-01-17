import 'package:flame_audio/flame_audio.dart';

class PacmanSounds {
  static Future start() async {
    FlameAudio.bgm.initialize();

    await FlameAudio.audioCache.loadAll([
      'pacman_beginning.mp3',
      'pacman_chomp.mp3',
      'pacman_death.wav',
      'pacman_intermission.mp3'
    ]);
  }

  static void begin() {
    FlameAudio.play('pacman_beginning.mp3');
  }

  static void chomp() {
    FlameAudio.play('pacman_chomp.mp3');
  }

  static void death() {
    FlameAudio.play('pacman_death.wav');
  }

  static void intermission() {
    FlameAudio.play('pacman_intermission.mp3');
  }
}
