// ignore_for_file: use_build_context_synchronously, prefer_const_constructors, must_be_immutable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flame/flame.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gamify/MyApp/loginscreen.dart';
import 'package:gamify/dino/main.dart';
import 'package:gamify/dungeon/menu.dart';
import 'package:gamify/flappybird/Layouts/Pages/page_start_screen.dart';
import 'package:gamify/jumper/navigation/routes.dart';
import 'package:gamify/minesweeper/game_activity.dart';
import 'package:gamify/pacman/HomePage.dart';
import 'package:gamify/pacman/sounds.dart';
import 'package:gamify/spacescape/lib/game/audio_player_component.dart';
import 'package:gamify/spacescape/lib/screens/main_menu.dart';
import 'package:gamify/tetris/lib/main.dart';
import 'package:hive/hive.dart';
import 'package:infinite_carousel/infinite_carousel.dart';

import '../chess/gameBoard.dart';
import '../dungeon/util/sounds.dart';
import '../jumper/assets.dart';
import '../jumper/high_scores.dart';
import '../jumper/sounds.dart';
import '../jumper/ui/main_menu_screen.dart';
import '../main.dart';

class GameScreen extends StatelessWidget {
  GameScreen({super.key});
  List<MyCard> cards = [
    MyCard(
      "assets/mainimages/dungeonmaster.png",
      LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: const [Color(0xFFA170BA), Color(0xFF0D161F)],
      ),
    ),
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
    MyCard(
      "assets/mainimages/jumpmaster.png",
      LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: const [Color(0xFF21C6FF), Color(0xFF0D161F)],
      ),
    ),
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
      if (!kIsWeb) {
        await Flame.device.setLandscape();
        await Flame.device.fullScreen();
      }

      await Sounds.initialize();
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => DungeonScreen()));
    };
    cards[1].function = () async {
      await JumperSounds.start();
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const DinoScreen()));
    };
    cards[2].function = () {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => MineSweeperScreen()));
    };
    cards[3].function = () async {
      await Flame.device.fullScreen();
      if (!loadedScore && !loadedAssets) {
        await HighScores.load();
        await Assets.load();
      }
      await JumperSounds.start();
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const JumperScreen()));
    };
    cards[4].function = () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => TetrisScreen()));
    };
    cards[5].function = () async {
      await Hive.openBox('user');
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const FlappyScreen()));
    };
    cards[6].function = () async {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Spacescape()));

      await Flame.device.fullScreen();
      await AudioPlayerComponent.start();
    };
    cards[7].function = () async {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => PacmanScreen()));
      await PacmanSounds.start();
    };
    cards[8].function = () {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const ChessScreen()));
    };
    context = context;
    screenSizeActual = MediaQuery.of(context).size;
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'BungeeInLine',
      ),
      onGenerateRoute: Routes.routes,
      debugShowCheckedModeBanner: false,
      home: Builder(builder: (context) {
        return SafeArea(
          child: Scaffold(
            body: Stack(
              children: [
                CardsList(cards),
                Positioned(
                  top: 16, // Position at the top
                  left: 0, // Align to the left
                  right: 0, // Align to the right
                  child: Center(
                    child: Image.asset(
                      "assets/gamify_icon.png",
                      width: 50, // Adjust the width as needed
                      height: 50, // Adjust the height as needed
                    ),
                  ),
                ),
                Positioned(
                    top: 16, // Adjust the top position as needed
                    left: 16, // Adjust the left position as needed
                    child: FirebaseAuth.instance.currentUser != null
                        ? ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black.withOpacity(
                                  0.7), // Remove the default background color
                              padding: EdgeInsets.all(
                                  16.0), // Add padding around the button
                              elevation: 20, // Remove the default elevation
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    10.0), // Rounded corners
                                side: BorderSide(
                                  color: Colors.white.withOpacity(
                                      0.3), // Add a border with a white color
                                  width: 2.0,
                                ),
                              ),
                            ),
                            onPressed: () {
                              FirebaseAuth.instance.signOut();
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginScreen(),
                                ),
                                (route) => false,
                              );
                            },
                            child: const Icon(
                              Icons.logout,
                              size: 30,
                            ),
                          )
                        : ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black.withOpacity(
                                  0.7), // Remove the default background color
                              padding: EdgeInsets.all(
                                  16.0), // Add padding around the button
                              elevation: 20, // Remove the default elevation
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    10.0), // Rounded corners
                                side: BorderSide(
                                  color: Colors.white.withOpacity(
                                      0.3), // Add a border with a white color
                                  width: 2.0,
                                ),
                              ),
                            ),
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginScreen(),
                                ),
                                (route) => false,
                              );
                            },
                            child: Icon(
                              Icons.arrow_back,
                              size: 30,
                              color: Colors
                                  .white, // Change the color of the icon to white
                            ),
                          )),
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
            currentGradient =
                widget.cards[newIndex].gradient; // Update gradient
          });
        },
        itemBuilder: (context, itemIndex, realIndex) {
          final card = widget.cards[itemIndex];
          final isFocused = itemIndex == selectedIndex;

          // Define the target scale value based on focus
          final targetScale = isFocused ? 1.1 : 1.0;

          return GestureDetector(
            onTap: () {
              card.function(); // Execute the onTap callback
            },
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300), // Animation duration
              curve: Curves.easeInOut, // Animation curve
              transform: Matrix4.identity()
                ..scale(targetScale), // Apply scaling
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
