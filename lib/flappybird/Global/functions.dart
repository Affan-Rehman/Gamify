// ignore_for_file: prefer_const_constructors
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:gamify/flappybird/Layouts/Pages/page_game.dart';
import 'package:gamify/flappybird/Layouts/Pages/page_settings.dart';
import '../../MyApp/gamescreen.dart';
import '../Database/database.dart';
import '../Resources/strings.dart';
import 'constant.dart';

Text myText(String txt, Color? color, double size) {
  return Text(
    txt,
    style: TextStyle(fontSize: size, fontFamily: "Magic4", color: color),
  );
}

ElevatedButton gameButton(VoidCallback? onPress, String txt, Color color) {
  return ElevatedButton(
    onPressed: onPress,
    style: ElevatedButton.styleFrom(primary: color),
    child: myText(txt, Colors.white, 20),
  );
}

BoxDecoration frame() {
  return BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.black, width: 2),
      color: Colors.white54,
      boxShadow: [
        BoxShadow(
            color: Colors.grey.withOpacity(0.6),
            blurRadius: 1.0,
            offset: Offset(5, 5))
      ]);
}

BoxDecoration background(String y) {
  return BoxDecoration(
    image: DecorationImage(
        image: AssetImage("assets/images/$y.png"), fit: BoxFit.fill),
  );
}

AlertDialog dialog(BuildContext context) {
  return AlertDialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
    actionsPadding: EdgeInsets.only(right: 8, bottom: 8),
    title: myText("About Flappy Bird", Colors.black, 22),
    content: Text(
      Str.about,
      style: TextStyle(fontFamily: "Magic4"),
    ),
    actions: [
      gameButton(() {
        Navigator.pop(context);
      }, "Okay", Colors.deepOrange),
    ],
  );
}

void init() {
  if (read("score") != null) {
    topScore = read("score");
  } else {
    write("score", topScore);
  }
  if (read("background") != null) {
    Str.image = read("background");
  } else {
    write("background", Str.image);
  }
  if (read("bird") != null) {
    Str.bird = read("bird");
  } else {
    write("bird", Str.bird);
  }
  if (read("level") != null) {
    barrierMovement = read("level");
  } else {
    write("level", barrierMovement);
  }
  if (read("audio") != null) {
    play = read("audio");
  } else {
    write("audio", play);
  }
  if (play) {
    player.play(AssetSource("Tintin.mp3"));
  } else {
    player.stop();
  }
  player.setReleaseMode(ReleaseMode.loop);
}

Future<void> navigate(context, navigate) async {
  switch (navigate) {
    case Str.gamePage:
      Navigator.push(context, MaterialPageRoute(builder: (context) => GamePage()));
      break;
    case Str.settings:
      Navigator.push(context, MaterialPageRoute(builder: (context) => const Settings()));
      break;
    case "exit":
      await player.stop();
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => GameScreen()),
        (Route<dynamic> route) => false,
      );
      break;
  }
}
