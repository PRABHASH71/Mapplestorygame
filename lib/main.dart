import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mapplestory/boy.dart';
import 'package:mapplestory/button.dart';
import 'package:mapplestory/dragon.dart';
import 'package:mapplestory/snail.dart';
import 'package:mapplestory/teddy.dart';

void main() {
  runApp(const MyApp());
  SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool loose = false;
  bool win = false;
  double time = 0;
  bool midjump = false;
  bool start = false;
  int snailcount = 1;
  double snailposX = 0.8;
  String snaildirection = "left";
  int dragoncount = 1;
  double dragonposX = 1;
  String dragondirection = "left";

  int attackboycount = 0;
  int teddycount = 1;
  double teddyposX = 0;
  String teddydirection = "right";
  int boycount = 1;
  double boyposX = -0.5;
  double boyposY = 1;
  String boydirection = "right";
  int attackdragon = 0;
  int attackbeast = 0;

  void startGame() {
    if (start == false) {
      moveSnail();
      moveteddy();
      moveDragon();
      start = true;
    }
  }

  void moveSnail() {
    Timer.periodic(Duration(milliseconds: 150), (timer) {
      setState(() {
        snailcount++;
        if (snaildirection == "left") {
          snailposX -= 0.01;
          if ((boyposX - snailposX).abs() < 0.2) {
            Timer.periodic(Duration(milliseconds: 100), (timer) {
              setState(() {
                attackbeast++;
              });
              if (attackbeast == 2) {
                attackbeast = 0;
                timer.cancel();
              }
            });
          }
          if ((snailposX - boyposX).abs() < 0.18) {
            loose = true;
          }
        } else {
          if ((boyposX - snailposX).abs() < 0.2) {
            Timer.periodic(Duration(milliseconds: 100), (timer) {
              setState(() {
                attackbeast++;
              });
              if (attackbeast == 2) {
                attackbeast = 0;
                timer.cancel();
              }
            });
          }
          if ((snailposX - boyposX).abs() < 0.18) {
            loose = true;
          }
          snailposX += 0.01;
        }
        if (snailposX < -0.8) {
          snaildirection = 'right';
        } else if (snailposX > 0.6) {
          snaildirection = 'left';
        }
        if (snailcount == 6) {
          snailcount = 1;
        }
      });
    });
  }

  void moveDragon() {
    Timer.periodic(Duration(milliseconds: 150), (timer) {
      setState(() {
        dragoncount++;
        if (dragondirection == "left") {
          dragonposX -= 0.01;
        } else {
          dragonposX += 0.01;
        }
        if (dragonposX < -0.7) {
          dragondirection = 'right';
        } else if (dragonposX > 0.6) {
          dragondirection = 'left';
        }
        if (dragoncount == 5) {
          dragoncount = 1;
        }
      });
    });
  }

  void moveteddy() {
    Timer.periodic(Duration(milliseconds: 100), (timer) {
      setState(() {
        teddycount++;
        if (teddycount == 20) {
          teddycount = 1;
        }

        if ((teddyposX - boyposX).abs() > 0.1) {
          if (boydirection == 'right') {
            teddyposX = boyposX - 0.2;
          } else if (boydirection == 'left') {
            teddyposX = boyposX + 0.2;
          }
        }
        if (teddyposX - boyposX > 0) {
          teddydirection = 'left';
        } else {
          teddydirection = 'right';
        }
      });
    });
  }

  void moveright() {
    setState(() {
      boyposX += 0.03;
      boycount++;
      boydirection = "right";
    });
    if (boyposX > 0.9) {
      win = true;
    }
    if ((boyposX - snailposX).abs() < 0.3) {
      Timer.periodic(Duration(milliseconds: 100), (timer) {
        setState(() {
          attackbeast++;
        });
        if (attackbeast == 2) {
          attackbeast = 0;
          timer.cancel();
        }
      });
    }
    if ((boyposX - snailposX).abs() < 0.2 && (boyposY - 1).abs() < 0.03) {
      loose = true;
    }
  }

  void prejump() {
    time = 0;
  }

  void attack() {
    Timer.periodic(Duration(milliseconds: 100), (timer) {
      setState(() {
        attackboycount++;
      });
      if (attackboycount == 6) {
        if (boydirection == "right" && boyposX + 0.4 > snailposX) {
          snailposX = 2;
          Timer.periodic(Duration(seconds: 5), (timer) {
            setState(() {
              snailposX = 0.8;
            });
          });
        } else {
          print("missed");
        }
        attackboycount = 0;
        timer.cancel();
      }
    });
  }

  void jump() {
    double height = 0;
    double initialaHeight = boyposY;
    if (midjump == false) {
      midjump = true;
      prejump();
      Timer.periodic(Duration(milliseconds: 50), (timer) {
        time += 0.05;
        height = -4.9 * time * time + 5 * time;
        if ((boyposX - dragonposX).abs() < 0.07) {
          Timer.periodic(Duration(milliseconds: 100), (timer) {
            setState(() {
              attackdragon++;
            });
            if (attackdragon == 3) {
              attackdragon = 0;
              timer.cancel();
            }
          });
        }
        if ((boyposX - dragonposX).abs() < 0.03) {
          loose = true;
        }
        if (initialaHeight - height > 1) {
          midjump = false;
          timer.cancel();
          setState(() {
            boyposY = 1;
          });
        } else {
          setState(() {
            boyposY = initialaHeight - height;
          });
        }
      });
    }
  }

  void moveleft() {
    setState(() {
      boyposX -= 0.03;
      boycount++;
      boydirection = "left";
    });
    if ((boyposX - snailposX).abs() < 0.03 && (boyposY - 1).abs() < 0.03) {
      loose = true;
    }
  }

  void restart() {
    loose == false;
  }

  @override
  Widget build(BuildContext context) {
    if (win == true) {
      return Scaffold(
        body: Container(
          decoration: BoxDecoration(color: Colors.green),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "YOU WIN :)",
                  style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                SizedBox(
                  height: 30,
                ),
                MaterialButton(
                  color: Colors.blue,
                  child: Text(
                    "RESTART",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    restart();

                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomePage()));
                  },
                ),
              ],
            ),
          ),
        ),
      );
    } else if (loose == true) {
      return Scaffold(
        body: Container(
          decoration: BoxDecoration(color: Colors.red),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "YOU LOOSE",
                  style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                SizedBox(
                  height: 30,
                ),
                MaterialButton(
                  color: Colors.blue,
                  child: Text(
                    "RESTART",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    restart();

                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomePage()));
                  },
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return Scaffold(
        body: Column(children: [
          Expanded(
              flex: 2,
              child: Container(
                color: Colors.blue[300],
                child: Stack(
                  children: [
                    Container(
                      alignment: Alignment(dragonposX, -0.6),
                      child: Mydragon(
                        dragonDirection: dragondirection,
                        dragoncount: dragoncount,
                        attackdragon: attackdragon,
                      ),
                    ),
                    Container(
                      alignment: Alignment(snailposX, 1),
                      child: BlueSnail(
                        snailDirection: snaildirection,
                        snailcount: snailcount,
                        attackbeast: attackbeast,
                      ),
                    ),
                    Container(
                      alignment: Alignment(boyposX, boyposY),
                      child: Myboy(
                        attackcount: attackboycount,
                        boydirection: boydirection,
                        boycount: boycount % 2 + 1,
                      ),
                    ),
                    Container(
                      alignment: Alignment(teddyposX, 1),
                      child: Myteddy(
                        teddyDirection: teddydirection,
                        teddycount: teddycount,
                      ),
                    ),
                  ],
                ),
              )),
          Container(
            height: 20,
            color: Colors.green,
          ),
          Expanded(
              child: Container(
            color: Colors.grey[900],
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "M A P L E S T O R Y",
                    style: TextStyle(color: Colors.white),
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        MyButton(
                          text: "PLAY",
                          function: () {
                            startGame();
                          },
                        ),
                        MyButton(
                          text: "ATTACK",
                          function: () {
                            attack();
                          },
                        ),
                        MyButton(
                          text: " LEFT ",
                          function: () {
                            moveleft();
                          },
                        ),
                        MyButton(
                          text: "JUMP",
                          function: () {
                            jump();
                          },
                        ),
                        MyButton(
                          text: "RIGHT",
                          function: () {
                            moveright();
                          },
                        ),
                      ]),
                ],
              ),
            ),
          )),
        ]),
      );
    }
  }
}
