import 'dart:math';

import 'package:flutter/material.dart';

class Myteddy extends StatelessWidget {
  final teddycount;
  final teddyDirection;

  const Myteddy({this.teddycount, this.teddyDirection});

  @override
  Widget build(BuildContext context) {
    if (teddyDirection == "left") {
      return Container(
        alignment: Alignment.bottomCenter,
        height: 40,
        width: 40,
        child: Image.asset('assets/t' + teddycount.toString() + '.png'),
      );
    } else {
      return Transform(
        alignment: Alignment.center,
        transform: Matrix4.rotationY(pi),
        child: Container(
          alignment: Alignment.bottomCenter,
          height: 40,
          width: 40,
          child: Image.asset('assets/t' + teddycount.toString() + '.png'),
        ),
      );
    }
  }
}
