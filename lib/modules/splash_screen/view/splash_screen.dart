import 'package:flutter/material.dart';

import '../../../config/app/view/app.dart';
import '../../home/view/view.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  skipSplashScreen() {
    Future.delayed(const Duration(milliseconds: 1800), () {
      Navigator.pushAndRemoveUntil(
          RememberApp.navigatorKey.currentContext!,
          MaterialPageRoute(builder: (context) => const MainScreen()),
          (route) => false);
    });
  }

  @override
  void initState() {
    skipSplashScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image.asset(
        "assets/images/logo.jpeg",
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      ),
    );
  }
}
