import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gymbro/main.dart';
import 'package:rive/rive.dart';

class SplashView extends StatefulWidget {

  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with SingleTickerProviderStateMixin{

  @override
  void initState() {
    //removing the top and bottom bar from screen when initial
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    super.initState();

    // Count down for Splash Screen
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => const HomePage()
        )
      );
    });
  }

  @override
  void dispose() {
    //relaunch the top and bottom bar when disposed
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: RiveAnimation.asset(
          'assets/gymbro_splash.riv',
          fit: BoxFit.fitHeight,       
          ),
      ),
    );
  }
}