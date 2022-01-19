import 'dart:async';

import 'package:flutter/material.dart';
import 'package:leadsgo_apps/Screens/Welcome/welcome_screen.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:leadsgo_apps/constants.dart';
import 'package:leadsgo_apps/Animation/FadeAnimation.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LauncherScreen extends StatefulWidget {
  @override
  _LauncherPageState createState() => new _LauncherPageState();
}

class _LauncherPageState extends State<LauncherScreen> with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: const Duration(milliseconds: 1000), vsync: this, value: 0.1);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.bounceOut);
    _controller.forward();
  }

  dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Timer(
      Duration(seconds: 5),
      () => Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) => WelcomeScreen(),
        ),
      ),
    );
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: ScaleTransition(
                scale: _animation,
                child: Image(
                  image: AssetImage('assets/LeadsGo_logo.png'),
                  width: size.height * 0.30,
                ),
              ),
            ),
            Center(
              child: SpinKitThreeBounce(
                color: leadsGoColor.withOpacity(0.2),
                size: 50.0,
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        padding: EdgeInsets.fromLTRB(0, 10, 0, 30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FadeAnimation(
              1,
              Container(
                // padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: Text(
                  "Berkerjasama dengan :",
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontFamily: 'LeadsGo-Font',
                    color: Colors.black,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
            Container(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FadeAnimation(
                      1.2,
                      Container(
                        child: Image(
                          image: AssetImage('assets/tetra_logo.png'),
                          height: 54,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    FadeAnimation(
                      1.3,
                      Container(
                        child: Image(
                          image: AssetImage('assets/Logo_Bukopin.png'),
                          height: 60,
                        ),
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
