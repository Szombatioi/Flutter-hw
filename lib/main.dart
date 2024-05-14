import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hf/http_communication.dart';
import 'package:flutter_hf/http_data/data_storage.dart';
import 'package:flutter_hf/pages/splash_screen.dart';
import 'package:get_it/get_it.dart';

void main() {
  GetIt.I.registerSingleton<Dio>(Dio());
  GetIt.I.registerSingleton<DataStorage>(DataStorage());
  GetIt.I.registerSingleton<HttpCommunication>(HttpCommunication());
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
        fontFamily: 'StarWarsFont',
        textTheme: const TextTheme(
            bodyLarge: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
            bodyMedium: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
            bodySmall: TextStyle(color: Colors.white, fontSize: 14)

        ),
      ),
      home: const SplashScreen(),
    );
  }
}