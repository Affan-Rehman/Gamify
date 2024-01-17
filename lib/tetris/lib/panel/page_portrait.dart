import 'package:flutter/material.dart';
import 'package:gamify/tetris/lib/main.dart';
import 'package:gamify/tetris/lib/panel/controller.dart';
import 'package:gamify/tetris/lib/panel/screen.dart';

part 'page_land.dart';

class PagePortrait extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenW = size.width * 0.8;

    return SizedBox.expand(
      child: Container(
        color: BACKGROUND_COLOR,
        child: Padding(
          padding: MediaQuery.of(context).padding,
          child: Column(
            children: <Widget>[
              const Spacer(),
              _ScreenDecoration(child: Screen(width: screenW)),
              const Spacer(flex: 2),
              const GameController(),
            ],
          ),
        ),
      ),
    );
  }
}

class _ScreenDecoration extends StatelessWidget {
  final Widget child;

  const _ScreenDecoration({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
              color:  Colors.white, width: SCREEN_BORDER_WIDTH),
          left: BorderSide(
              color: Colors.white, width: SCREEN_BORDER_WIDTH),
          right: BorderSide(
              color: Colors.white, width: SCREEN_BORDER_WIDTH),
          bottom: BorderSide(
              color: Colors.white, width: SCREEN_BORDER_WIDTH),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.white)),
        child: Container(
          padding: const EdgeInsets.all(3),
          color: SCREEN_BACKGROUND,
          child: child,
        ),
      ),
    );
  }
}
