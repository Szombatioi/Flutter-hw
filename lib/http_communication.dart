import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter_hf/http_data/data_storage.dart';
import 'package:flutter_hf/http_data/movie_response.dart';
import 'package:flutter_hf/http_data/character_response.dart';
import 'http_data/data/movie.dart';
import 'http_data/data/character.dart';

class HttpCommunication {
  final Dio dio = Dio();
  static final HttpCommunication _singleton = HttpCommunication._internal();

  factory HttpCommunication(){
    return _singleton;
  }

  HttpCommunication._internal(){
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (HttpClient client) {
      client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
      return client;
    };
  }

  Future<void> startGatheringInfo() async{
    //here we start calling the API. Firstly we call for characters, then the vehicles, spaceships, etc.
    //FIXED: we already did this in the data classes' constructors! (we also connect the objects with each other, meaning we connect the characters' vehicles to existing vehicles)

  }

  Future<List<Movie>?> getMovies() async {
    List<Movie>? movies;
    try{
      Response res = await dio.get('https://swapi.dev/api/films');
      MovieResponse response = MovieResponse.fromJson(res.data);
      movies = response.results!;
      //movies.sort();
      for (var m in movies) {
        print(m.title);
      }
    } catch(e){
      print(e.toString());
    }
    return movies;
  }

  Future<Character?> getCharacter(String url) async{
    try{
      Response res = await dio.get(url);
      return Character.fromJson(res.data);
    } catch(e){
      print("Error: $e");
    }
  }

  Future<CharacterResponse?> getCharacters({int page = 1}) async{
    try{
      Response res = await dio.get('https://swapi.dev/api/people/?page=$page');
      return CharacterResponse.fromJson(res.data);
    } catch(e){
      print(e.toString());
    }
  }

}