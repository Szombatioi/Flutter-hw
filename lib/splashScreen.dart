import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hf/http_communication.dart';
import 'package:flutter_hf/main.dart';

import 'mainPage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    HttpCommunication().startLoading().then((value) => {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const HomePage("Main page")))
        });
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF1D6D38), Color(0xFF282828)],
              stops: [0.0, 0.25],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/logo.png',
                fit: BoxFit.fitWidth,
                width: 256,
              ),
              const Text(
                "Star Wars character",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          )),
    );
  }
}
