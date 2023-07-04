import 'package:flutter/material.dart';
import 'dart:math';

class BlueSnail extends StatelessWidget {
  final snailcount;
  final snailDirection;
  final attackbeast;
  BlueSnail({this.snailcount, this.snailDirection, this.attackbeast});

  @override
  Widget build(BuildContext context) {
    if (attackbeast > 0) {
      if (snailDirection == "left") {
        return Container(
          alignment: Alignment.bottomCenter,
          height: 170,
          width: 170,
          child: Image.asset('assets/atbt' + snailcount.toString() + '.png'),
        );
      } else {
        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.rotationY(pi),
          child: Container(
            alignment: Alignment.bottomCenter,
            height: 170,
            width: 170,
            child: Image.asset('assets/atbt' + snailcount.toString() + '.png'),
          ),
        );
      }
    } else if (snailDirection == "left") {
      return Container(
        alignment: Alignment.bottomCenter,
        height: 120,
        width: 120,
        child: Image.asset('assets/beast' + snailcount.toString() + '.png'),
      );
    } else {
      return Transform(
        alignment: Alignment.center,
        transform: Matrix4.rotationY(pi),
        child: Container(
          alignment: Alignment.bottomCenter,
          height: 120,
          width: 120,
          child: Image.asset('assets/beast' + snailcount.toString() + '.png'),
        ),
      );
    }
  }
}
