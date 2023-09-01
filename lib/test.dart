import 'dart:async';

import 'package:flappy_bird/barrier.dart';
import 'package:flappy_bird/bird.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static double birdYAxis = 0;
  double time = 0;
  double height = 0;
  double initialHeight = birdYAxis;
  bool gameHasStarted = false;
  static double barrierXone = 1;

  //creating a barrier little bit further from barrierXone
  double barrierXtwo = barrierXone + 1.5;

  void jump() {
    setState(() {
      time = 0;
      initialHeight = birdYAxis;
    });
  }

  void startGame() {
    gameHasStarted = true;
    //we are changing a frame in every sixty milliseconds
    Timer.periodic(const Duration(milliseconds: 60), (timer) {
      //this is a displacement formula where y=height and t= time y= -1/2gt^2 +vt
      //at a certain time it goes to maximum height and comes down due to gravity

      time += 0.04;
      height = -4.9 * time * time + 2.8 * time; //v=2.8
      setState(() {
        birdYAxis = initialHeight - height;
        barrierXone -= 0.05;
        barrierXtwo -= 0.05;
      });
      //landing bird on ground
      if (birdYAxis > 1) {
        timer.cancel();
        gameHasStarted = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
                    if (gameHasStarted == true) {
                      jump();
                    } else {
                      startGame();
                    }
                  },
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 2,
              child: Stack(
                children: [
                  
                  AnimatedContainer(
                    alignment: Alignment(0, birdYAxis),
                    duration: const Duration(milliseconds: 0),
                    color: Colors.blue,
                    child: const MyBird(),
                  ),
                  Container(
                    alignment: const Alignment(0, -0.3),
                    child: gameHasStarted
                        ? const Text(" ")
                        : const Text(
                            "TAP TO PLAY",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 2,
                            ),
                          ),
                  ),
                  AnimatedContainer(
                    alignment: Alignment(barrierXone, 1.1),
                    duration: const Duration(milliseconds: 0),
                    child:  MyBarrier(
                      size: MediaQuery.of(context).size.height * 0.28,
                    ),
                  ),
                  AnimatedContainer(
                    alignment: Alignment(barrierXone, -1.1),
                    duration: const Duration(milliseconds: 0),
                    child:  MyBarrier(
                      size: MediaQuery.of(context).size.height * 0.24,
                    ),
                  ),
                  AnimatedContainer(
                    alignment: Alignment(barrierXtwo, 1.1),
                    duration: const Duration(milliseconds: 0),
                    child: const MyBarrier(
                      size: 150.0,
                    ),
                  ),
                  AnimatedContainer(
                    alignment: Alignment(barrierXtwo, -1.1),
                    duration: const Duration(milliseconds: 0),
                    child:  MyBarrier(
                      size: MediaQuery.of(context).size.height * 0.3,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 15,
              color: Colors.green,
            ),
            Expanded(
              child: Container(
                color: Colors.brown,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "SCORE",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "0",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 35),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "BEST",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "10",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 35),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
