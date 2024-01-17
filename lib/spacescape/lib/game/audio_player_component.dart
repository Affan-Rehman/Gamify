
import 'package:flame_audio/flame_audio.dart';



class AudioPlayerComponent {
  static Future start() async {
    FlameAudio.bgm.initialize();

    await FlameAudio.audioCache
        .loadAll(['laser1.mp3', 'powerUp6.mp3', 'laserSmall_001.mp3']);

  }

  static stopBackgroundSound() {
    return FlameAudio.bgm.stop();
  }

  static void playBackgroundSound() async {
    await FlameAudio.bgm.stop();
    FlameAudio.bgm.play('space_shooter_theme.mp3');
  }

  static void shootSmallLaser() {FlameAudio.play('laserSmall_001.mp3', volume: 0.4);}
  static void shootLaser() {FlameAudio.play('laser1.mp3', volume: 0.4);}
  static void powerUp() {FlameAudio.play('powerUp6.mp3', volume: 0.4);}
}
