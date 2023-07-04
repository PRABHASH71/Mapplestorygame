import 'package:flutter/material.dart';
import 'dart:math';

class Mydragon extends StatelessWidget {
  final dragoncount;
  final dragonDirection;
  final attackdragon;
  Mydragon({this.dragonDirection, this.dragoncount, this.attackdragon});

  @override
  Widget build(BuildContext context) {
    if (attackdragon > 0) {
      if (dragonDirection == "left") {
        return Container(
          alignment: Alignment.bottomCenter,
          height: 80,
          width: 80,
          child: Image.asset('assets/ad' + dragoncount.toString() + '.png'),
        );
      } else {
        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.rotationY(pi),
          child: Container(
            alignment: Alignment.bottomCenter,
            height: 80,
            width: 80,
            child: Image.asset('assets/dr' + dragoncount.toString() + '.png'),
          ),
        );
      }
    } else if (dragonDirection == "left") {
      return Container(
        alignment: Alignment.bottomCenter,
        height: 80,
        width: 80,
        child: Image.asset('assets/dr' + dragoncount.toString() + '.png'),
      );
    } else {
      return Transform(
        alignment: Alignment.center,
        transform: Matrix4.rotationY(pi),
        child: Container(
          alignment: Alignment.bottomCenter,
          height: 80,
          width: 80,
          child: Image.asset('assets/dr' + dragoncount.toString() + '.png'),
        ),
      );
    }
  }
}
