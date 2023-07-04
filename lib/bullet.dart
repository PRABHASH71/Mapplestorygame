import 'package:flutter/material.dart';

class Mybullet extends StatelessWidget {
  const Mybullet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      height: 70,
      width: 70,
      child: Image.asset('assets/go.png'),
    );
    ;
  }
}
