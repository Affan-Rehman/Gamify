import 'package:flutter/material.dart';

class MyGhost extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(2),
      child: Image.asset('assets/pacman/images/ghost.png'),
    );
  }
}
