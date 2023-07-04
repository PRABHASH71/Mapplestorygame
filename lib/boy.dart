import 'dart:math';

import 'package:flutter/material.dart';

class Myboy extends StatelessWidget {
  final boydirection;
  final attackcount;
  final boycount;
  const Myboy({this.boycount, this.boydirection, this.attackcount});

  @override
  Widget build(BuildContext context) {
    if (attackcount > 0 && boydirection == "right") {
      return Transform(
        alignment: Alignment.center,
        transform: Matrix4.rotationY(pi),
        child: Container(
          alignment: Alignment.bottomCenter,
          height: 80,
          width: 80,
          child: Image.asset('assets/ab' + attackcount.toString() + '.png'),
        ),
      );
    } else if (boydirection == "left") {
      return Container(
        alignment: Alignment.bottomCenter,
        height: 60,
        width: 60,
        child: Image.asset('assets/h' + boycount.toString() + '.png'),
      );
    } else {
      return Transform(
        alignment: Alignment.center,
        transform: Matrix4.rotationY(pi),
        child: Container(
          alignment: Alignment.bottomCenter,
          height: 60,
          width: 60,
          child: Image.asset('assets/h' + boycount.toString() + '.png'),
        ),
      );
    }
  }
}
