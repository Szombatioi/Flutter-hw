import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hf/http_service.dart';
import 'package:flutter_hf/pages/main_page.dart';
import 'package:flutter_hf/providers/swapi_provider.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

void main() {
  GetIt.I.registerSingleton<Dio>(Dio());
  GetIt.I.registerSingleton<HttpService>(HttpService());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => SwapiProvider(GetIt.I<HttpService>()),
        ),
      ],
      child: MaterialApp(
        title: 'Star Wars Characters',
        theme: ThemeData(
          primaryColor: Colors.white,
          fontFamily: 'StarWarsFont',
          textTheme: const TextTheme(
              bodyLarge: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold),
              bodyMedium: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
              bodySmall: TextStyle(color: Colors.white, fontSize: 14)),
        ),
        home: const HomePage(),
      ),
    );
  }
}
