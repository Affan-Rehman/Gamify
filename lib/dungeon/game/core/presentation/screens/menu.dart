import 'package:flutter/material.dart';
import 'package:gamify/MyApp/gamescreen.dart';

import '../widgets/pixel_button.dart';
import 'game_play.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF211F30),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                'Pixel Adventure',
                style: TextStyle(
                  fontFamily: 'PixelifySans',
                  fontSize: 64,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 32),
            PixelButton(
              text: 'Play',
              icon: Image.asset(
                'assets/images/Menu/Buttons/Play.png',
                height: 24,
                width: 24,
                fit: BoxFit.cover,
              ),
              onPressed: () => Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const GamePlay(),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            PixelButton(
              text: 'Exit',
              icon: const Icon(
                Icons.exit_to_app,
                color: Colors.white,
              ),
              onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => GameScreen(),
                ),
                (routes) => false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
