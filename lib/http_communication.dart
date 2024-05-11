import 'dart:io';

//import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter_hf/HTTP data/film_response.dart';
import 'package:flutter_hf/HTTP%20data/person_response.dart';
import 'HTTP data/film.dart';
import 'HTTP data/person.dart';

class HttpCommunication {
  final Dio dio = Dio();

  HttpCommunication(){
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (HttpClient client) {
      client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
      return client;
    };
  }

  Future<List<Film>?> getMovies() async {
    List<Film>? movies;
    try{
      Response res = await dio.get('https://swapi.dev/api/films');
      FilmResponse response = FilmResponse.fromJson(res.data);
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

  Future<Person?> getCharacter(String url) async{
    try{
      Response res = await dio.get(url);
      return Person.fromJson(res.data);
    } catch(e){
      print("Error: $e");
    }
  }

  Future<PersonResponse?> getCharacters({int page = 1}) async{
    try{
      Response res = await dio.get('https://swapi.dev/api/people/?page=$page');
      return PersonResponse.fromJson(res.data);
    } catch(e){
      print(e.toString());
    }
  }

}