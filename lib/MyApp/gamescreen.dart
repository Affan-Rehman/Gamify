// ignore_for_file: use_build_context_synchronously, prefer_const_constructors, must_be_immutable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flame/flame.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gamify/MyApp/loginscreen.dart';
import 'package:gamify/dino/main.dart';
import 'package:gamify/flappybird/Layouts/Pages/page_start_screen.dart';
import 'package:gamify/minesweeper/game_activity.dart';
import 'package:gamify/pacman/HomePage.dart';
import 'package:gamify/pacman/sounds.dart';
import 'package:gamify/spacescape/lib/game/audio_player_component.dart';
import 'package:gamify/spacescape/lib/screens/main_menu.dart';
import 'package:gamify/tetris/lib/main.dart';
import 'package:hive/hive.dart';
import 'package:infinite_carousel/infinite_carousel.dart';

import '../chess/gameBoard.dart';
import '../dino/sounds.dart';
import '../main.dart';

class GameScreen extends StatelessWidget {
  GameScreen({super.key});
  List<MyCard> cards = [
    // MyCard(
    //   "assets/mainimages/dungeonmaster.png",
    //   LinearGradient(
    //     begin: Alignment.topCenter,
    //     end: Alignment.bottomCenter,
    //     colors: const [Color(0xFFA170BA), Color(0xFF0D161F)],
    //   ),
    // ),
    MyCard(
        "assets/mainimages/dinomaster.png",
        LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: const [
            Color(0xFFD08A64),
            Color(0xFF0D161F),
          ],
        )),
    MyCard(
      "assets/mainimages/minesweeper.png",
      LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: const [Color(0xFFCE69FE), Color(0xFF0D161F)],
      ),
    ),
    // MyCard(
    //   "assets/mainimages/jumpmaster.png",
    //   LinearGradient(
    //     begin: Alignment.topCenter,
    //     end: Alignment.bottomCenter,
    //     colors: const [Color(0xFF21C6FF), Color(0xFF0D161F)],
    //   ),
    // ),
    MyCard(
      "assets/mainimages/tetrix.png",
      LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: const [Color(0xFF90327F), Color(0xFF0D161F)],
      ),
    ),
    MyCard(
      "assets/mainimages/flappybird.png",
      LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: const [Color(0xFF84E28A), Color(0xFF0D161F)],
      ),
    ),
    MyCard(
      "assets/mainimages/spaceescape.png",
      LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: const [Color(0xFFB9B8B8), Color(0xFF0D161F)],
      ),
    ),
    MyCard(
      "assets/mainimages/pacman.png",
      LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: const [Color(0xFFF9D706), Color(0xFF0D161F)],
      ),
    ),
    MyCard(
      "assets/mainimages/chess.png",
      LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: const [Color(0xFFA5ADB0), Color(0xFF0D161F)],
      ),
    )
  ];

  @override
  Widget build(BuildContext context) {
    cards[0].function = () async {
      await DinoSounds.start();
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const DinoScreen()));
    };
    cards[1].function = () {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => MineSweeperScreen()));
    };
    cards[2].function = () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => TetrisScreen()));
    };
    cards[3].function = () async {
      await Hive.openBox('user');
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const FlappyScreen()));
    };
    cards[4].function = () async {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Spacescape()));

      await Flame.device.fullScreen();
      await AudioPlayerComponent.start();
    };
    cards[5].function = () async {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => PacmanScreen()));
      await PacmanSounds.start();
    };
    cards[6].function = () {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const ChessScreen()));
    };
    context = context;
    screenSizeActual = MediaQuery.of(context).size;
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'BungeeInLine',
      ),
      debugShowCheckedModeBanner: false,
      home: Builder(builder: (context) {
        return SafeArea(
          child: Scaffold(
            body: Stack(
              children: [
                CardsList(cards),
                Positioned(
                  top: 16,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Image.asset(
                      "assets/gamify_icon.png",
                      width: 50,
                      height: 50,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

class MyCard {
  String image;
  Gradient gradient;
  late VoidCallback function;
  MyCard(this.image, this.gradient);
}

class CardsList extends StatefulWidget {
  List<MyCard> cards;
  CardsList(this.cards);

  @override
  State<CardsList> createState() => _CardsListState();
}

class _CardsListState extends State<CardsList> {
  int selectedIndex = 0;
  Gradient currentGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: const [Color(0xFFA170BA), Color(0xFF0D161F)],
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: currentGradient, // Use the current gradient
      ),
      child: InfiniteCarousel.builder(
        itemCount: widget.cards.length,
        itemExtent: MediaQuery.of(context).size.height * 0.35,
        loop: true,
        axisDirection: Axis.vertical,
        onIndexChanged: (newIndex) {
          setState(() {
            selectedIndex = newIndex;
            currentGradient = widget.cards[newIndex].gradient;
          });
        },
        itemBuilder: (context, itemIndex, realIndex) {
          final card = widget.cards[itemIndex];
          final isFocused = itemIndex == selectedIndex;

          // Define the target scale value based on focus
          final targetScale = isFocused ? 1.1 : 1.0;

          return GestureDetector(
            onTap: () {
              card.function();
            },
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              transform: Matrix4.identity()
                ..scale(targetScale)
                ..translate(
                  (MediaQuery.of(context).size.width * (1 - targetScale)) / 2,
                  0.0,
                ),
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  image: DecorationImage(
                    image: AssetImage(card.image),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
