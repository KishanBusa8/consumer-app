import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hashching/Utilities/simplefiedwidgets.dart';
import 'package:hashching/provider/stateprovider.dart';
import 'package:hashching/styles/styles.dart';
import 'dart:math' as math;

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controllerRotation;
   late final AnimationController _controller;
   late final Animation<double> _animation;

  initialStateData() {
    controllerProcess();
    animationProcess();
    timerNavigation();
  }

  controllerProcess() {
    _controller = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat(reverse: false);

    _controllerRotation = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat();
    stopController();
  }

  animationProcess() {
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    );
  }

  stopController() {
    Timer(Duration(seconds: 4), () {
      _controller.stop();
      _controllerRotation.stop();
    });
  }

  timerNavigation() {
    Timer(Duration(seconds: 5), () {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (_) =>  StateProvider(),//MainPage()
          ),
          (route) => false);
    });
  }

  @override
  void initState() {
    initialStateData();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _controllerRotation.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.ternary,
      body: Center(
        child: NewColumnMain(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ScaleTransition(
              scale: _animation,
              child: Transform.rotate(
                angle: -math.pi / 12.0,
                child: RotationTransition(
                  turns: Tween(begin: 0.0, end: 5.0).animate(_controller),
                  child: Container(
                    height: 67,width: 67,
                    child: SvgPicture.asset('assets/icons/hashching_logo.svg',fit: BoxFit.fill),
                  ),
                ),
              ),
            ),
            ScaleTransition(
                scale: _animation,
                child: Container(
                  child:
                  SvgPicture.asset('assets/icons/HashchingLogo.svg'),
                  // Image(image: AssetImage("assets/icons/hashching_image.png")),
                ))
          ], 
        ),
      ),
    );
  }
}




