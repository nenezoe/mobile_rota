import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../speech_screen.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with TickerProviderStateMixin {
  double? _scale;

  AnimationController? _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 500,
      ),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _controller!.value;
    return Scaffold(
      backgroundColor: Color(0xff031a28),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              'assets/images/rotapadlogo.png',
              height: 170,
              width: 170,
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(
            height: 250,
          ),
          Text(
            'Get started by using your voice',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            ' to manage your team',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          InkWell(
            onTap: () {
              Get.to(SpeechScreen());
              // onTapDown:
              // _tapDown;
              // onTapUp:
              // _tapUp;
              // child:
              // Transform.scale(
              //   scale: _scale,
              //   child: _animatedButton(),
              // );
              // Get.to(SpeechToTextScreen());
            },
            // onTap: _.navigate,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 40.0, vertical: 24),
              child: Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Color(0xff7f00ff)
                    // color: Color(0xff084c70)
                    ),
                child: Center(
                  child: Text(
                    'Get Started!',
                    style: TextStyle(
                      // color: bgColor,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      // fontFamily: 'Figtree',
                      // type: FontType.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _animatedButton() {
    return Container(
      height: 70,
      width: 200,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          boxShadow: [
            BoxShadow(
              color: Color(0x80000000),
              blurRadius: 12.0,
              offset: Offset(0.0, 5.0),
            ),
          ],
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xff33ccff),
              Color(0xffff99cc),
            ],
          )),
      child: Center(
        child: Text(
          'Press',
          style: TextStyle(
              fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
    );
  }

  void _tapDown(TapDownDetails details) {
    _controller?.forward();
  }

  void _tapUp(TapUpDetails details) {
    _controller?.reverse();
  }
}
