import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gamify/MyApp/gamescreen.dart';
import 'package:gamify/MyApp/userauth.dart';

import '../main.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    screenSizeActual = MediaQuery.of(context).size;
    return Scaffold(
      
      body: Container(
        decoration: const BoxDecoration(color: Color(0xFF14212A)),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/gamify_icon.png"),
              const Text(
                "Gamify",
                style: TextStyle(
                  color: Color(0xFFEA4335),
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width *
                        0.6, // Set the width here
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => GameScreen()));
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              20.0), // Set the border radius here
                        ),
                        backgroundColor: const Color(
                            0xFF34495E), // Set the background color here
                      ),
                      child: const Text(
                        "Play as Guest",
                        style: TextStyle(color: Color(0xFFEA4335)),
                      ),
                    ),
                  )),
              Platform.isAndroid
                  ? const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: GoogleButton(),
                    )
                  : const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: AppleButton(),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
