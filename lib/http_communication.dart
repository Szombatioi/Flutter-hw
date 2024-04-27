import 'package:dio/dio.dart';
import 'package:flutter_hf/HTTP data/film_response.dart';
import 'package:flutter_hf/HTTP%20data/person_response.dart';
import 'HTTP data/film.dart';
import 'HTTP data/person.dart';

class HttpCommunication {
  final Dio dio = Dio();

  Future<List<Film>?> getMovies() async {
    List<Film>? movies;
    try{
      Response res = await dio.get('https://swapi.dev/api/films');
      FilmResponse response = FilmResponse.fromJson(res.data);
      movies = response.results!;
      for (var m in movies) {
        print(m.title);
      }
    } catch(e){
      print(e.toString());
    }
    return movies;
  }

  Future<List<Person>?> getCharacters() async{
    List<Person>? characters;
    try{
      Response res = await dio.get('https://swapi.dev/api/people');
      PersonResponse response = PersonResponse.fromJson(res.data);
      characters = response.results!;
      for (var m in characters) {
        print(m.name);
      }
    } catch(e){
      print(e.toString());
    }
    return characters;
  }

}