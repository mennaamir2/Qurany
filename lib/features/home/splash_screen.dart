import 'package:azkary/core/themes/color_app.dart';
import 'package:azkary/features/home/home.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(
      const Duration(seconds: 5),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const Home(),
        ),
      ),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorApp.secondaryColor,
      body: Center(
        child: Image.asset(
          "assets/images/azkar.png",
          width: 200,
          height: 200,
          // scale: .1,
        ),
      ),
      // backgroundColor: ColorApp.secondaryColor,
    );
  }
}
