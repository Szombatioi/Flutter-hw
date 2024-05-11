import 'package:flutter/material.dart';
import 'package:flutter_hf/http_communication.dart';
import 'package:flutter_hf/splashScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Star Wars Characters',
      theme: ThemeData(
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        // useMaterial3: true,
        primaryColor: Colors.white,
        fontFamily: "CarosBold", //TODO!!!
      ),
      home: const SplashScreen(),
    );
  }
}