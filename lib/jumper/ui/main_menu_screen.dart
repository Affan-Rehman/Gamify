import 'package:flutter/material.dart';
import 'package:gamify/jumper/sounds.dart';
import 'package:gamify/jumper/ui/widgets/my_button.dart';
import 'package:gamify/jumper/ui/widgets/my_text.dart';

import '../high_scores.dart';
import '../navigation/routes.dart';

class JumperScreen extends StatelessWidget {
  const JumperScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    JumperSounds.jumper();
    return Material(
      child: Center(
        child: AspectRatio(
          aspectRatio: 9 / 19.5,
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: LayoutBuilder(builder: (context, constrains) {
                return Stack(
                  children: [
                    Positioned(
                      bottom: constrains.maxHeight * .25,
                      child: Image.asset(
                        'assets/images/herojump.png',
                        scale: 1.25,
                      ),
                    ),
                    Positioned(
                      bottom: constrains.maxHeight * .60,
                      child: Image.asset(
                        'assets/images/fullmulti.png',
                        scale: 1.25,
                      ),
                    ),
                    Positioned(
                      bottom: constrains.maxHeight * .05,
                      left: constrains.maxWidth * .2,
                      child: Image.asset(
                        'assets/images/fullbeige.png',
                        scale: 1.25,
                      ),
                    ),
                    Positioned(
                      bottom: constrains.maxHeight * .3,
                      right: 0,
                      child: Image.asset(
                        'assets/images/fullblue.png',
                        scale: 1.5,
                      ),
                    ),
                    Positioned(
                      top: constrains.maxHeight * .3,
                      right: 0,
                      child: Image.asset(
                        'assets/images/happycloud.png',
                        scale: 1.75,
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(height: 24),
                        Image.asset('assets/images/title.png'),
                        MyText(
                          'Best Score: ${HighScores.highScores[0]}',
                          fontSize: 26,
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              MyButton(
                                'Play',
                                onPressed: () =>
                                    context.pushAndRemoveUntil(Routes.game),
                              ),
                              const SizedBox(height: 40),
                              MyButton(
                                'Leaderboard',
                                onPressed: () =>
                                    context.push(Routes.leaderboard),
                              ),
                              const SizedBox(height: 40),
                              MyButton(
                                'Exit',
                                onPressed: () {
                                  JumperSounds.stopJumper();
                                  context.pushAndRemoveUntil(Routes.main);
                                },
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
