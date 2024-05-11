import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter_hf/http_data/data_storage.dart';
import 'package:flutter_hf/http_data/movie_response.dart';
import 'package:flutter_hf/http_data/character_response.dart';
import 'package:flutter_hf/http_data/planet_response.dart';
import 'package:flutter_hf/http_data/species_response.dart';
import 'http_data/data/movie.dart';
import 'http_data/data/character.dart';
import 'http_data/data/planet.dart';
import 'http_data/starship_response.dart';
import 'http_data/vehicle_response.dart';

class HttpCommunication {
  final Dio dio = Dio();
  static final HttpCommunication _singleton = HttpCommunication._internal();
  bool finishedLoading = false;

  factory HttpCommunication(){
    return _singleton;
  }

  HttpCommunication._internal(){
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (HttpClient client) {
      client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
      return client;
    };
  }

  Future<void> startLoading() async{
    print("Characters loading");
    int page = 1;
    bool run = true;
    while(run){
      try{
        Response res = await dio.get('https://swapi.dev/api/people/?page=${page++}');
        CharacterResponse characterResponse = CharacterResponse.fromJson(res.data);
        DataStorage().characters.addAll(characterResponse.results!);
      } catch(e){
        print(e);
        run = false;
      }
    }
    // print("Charactercount: ${DataStorage().characters.length}");
    // for (var element in DataStorage().characters) {print(element.url);}

    print("Movies loading");
    Response res = await dio.get('https://swapi.dev/api/films');
    MovieResponse movieResponse = MovieResponse.fromJson(res.data);
    DataStorage().movies.addAll(movieResponse.results!);
    // print("Movies count: ${DataStorage().movies.length}");
    // for (var element in DataStorage().movies) {print(element.url);}

    print("Planets loading");
    run = true;
    page = 1;
    while(run){
      try{
        Response res = await dio.get('https://swapi.dev/api/planets/?page=${page++}');
        PlanetResponse planetResponse = PlanetResponse.fromJson(res.data!);
        DataStorage().planets.addAll(planetResponse.results!);
      } catch(e){
        //print(e);
        run = false;
      }
    }
    // print("Planets count: ${DataStorage().planets.length}");
    // for (var element in DataStorage().planets) {print(element.url);}

    print("Species loading");
    run = true;
    page = 1;
    while(run){
      try{
        Response res = await dio.get('https://swapi.dev/api/species/?page=${page++}');
        SpeciesResponse speciesResponse = SpeciesResponse.fromJson(res.data);
        DataStorage().species.addAll(speciesResponse.results!);
      } catch(e){
        print(e);
        run = false;
      }
    }
    // print("Speices count: ${DataStorage().species.length}");
    // for (var element in DataStorage().species) {print(element.url);}

    print("Starships loading");
    run = true;
    page = 1;
    while(run){
      try{
        Response res = await dio.get('https://swapi.dev/api/starships/?page=${page++}');
        StarshipsResponse starshipsResponse = StarshipsResponse.fromJson(res.data);
        DataStorage().starships.addAll(starshipsResponse.results!);
      } catch(e){
        run = false;
      }
    }
    // print("Starships count: ${DataStorage().starships.length}");
    // for (var element in DataStorage().starships) {print(element.url);}

    print("Vehicles loading");
    run = true;
    page = 1;
    while(run){
      try{
        Response res = await dio.get('https://swapi.dev/api/vehicles/?page=${page++}');
        VehicleResponse vehicleResponse = VehicleResponse.fromJson(res.data);
        DataStorage().vehicles.addAll(vehicleResponse.results!);
      } catch(e){
        run = false;
      }
    }
    // print("Vehicles count: ${DataStorage().vehicles.length}");
    // for (var element in DataStorage().vehicles) {print(element.url);}

    print("###Connecting lists###");
    print("Connecting characters");
    //Characters
    for(var character in DataStorage().characters){
      if(character.homeworld == null){
        HttpCommunication().getPlanet(character.homeworldUrl!).then((value) => character.homeworld = value);
      }
      if(character.movies.isEmpty){
        for(var url in character.moviesUrls!){
          character.movies.add(DataStorage().movies.firstWhere((element) => element.url == url));
        }
      }

      if(character.vehicles.isEmpty){
        for(var url in character.vehiclesUrls!){
          character.vehicles.add(DataStorage().vehicles.firstWhere((element) => element.url == url));
        }
      }

      if(character.species.isEmpty){
        for(var url in character.speciesUrls!){
          character.species.add(DataStorage().species.firstWhere((element) => element.url == url));
        }
      }

      if(character.starships.isEmpty){
        for(var url in character.starshipsUrls!){
          character.starships.add(DataStorage().starships.firstWhere((element) => element.url == url));
        }
      }
    }

    print("Connecting movies");
    //Movies - characters, planets, starships, vehicles, species
    for(var movie in DataStorage().movies){
      if(movie.characters!.isEmpty){
        try{
          for(var url in movie.charactersUrls!){
            movie.characters?.add(DataStorage().characters.firstWhere((element) => element.url == url));
          }
        }catch(e){
          print("Error was here: $e");
        }
      }

      if(movie.planets!.isEmpty){
        try{
        for(var url in movie.planetsUrls!){
          movie.planets?.add(DataStorage().planets.firstWhere((element) => element.url == url));
        }}catch(e){
          print("Error: $e");
        }
      }

      if(movie.starships!.isEmpty){
        try{
        for(var url in movie.starshipsUrls!){
          movie.starships?.add(DataStorage().starships.firstWhere((element) => element.url == url));
        }}catch(e){
          print("Error: $e");
        }
      }

      if(movie.vehicles!.isEmpty){
        try{
        for(var url in movie.vehiclesUrls!){
          movie.vehicles?.add(DataStorage().vehicles.firstWhere((element) => element.url == url));
        }}catch(e){
          print("Error: $e");
        }
      }

      if(movie.species!.isEmpty){
        try{
        for(var url in movie.speciesUrls!){
          movie.species?.add(DataStorage().species.firstWhere((element) => element.url == url));
        }}catch(e){
          print("Error: $e");
        }
      }
    }

    print("Connecting species");
    //Species - films, people
    for(var species in DataStorage().species) {
      if (species.people!.isEmpty) {
        for (var url in species.peopleUrls!) {
          species.people?.add(
              DataStorage().characters.firstWhere((element) => element.url == url));
        }
      }

      if (species.films!.isEmpty) {
        for (var url in species.filmsUrls!) {
          species.films?.add(
              DataStorage().movies.firstWhere((element) => element.url == url));
        }
      }
    }

    print("Connecting vehicles");
    //Vehicles - films, pilots
    for(var vehicle in DataStorage().vehicles) {
      if (vehicle.pilots!.isEmpty) {
        for (var url in vehicle.pilotsUrls!) {
          vehicle.pilots?.add(DataStorage().characters.firstWhere((element) => element.url == url));
        }
      }

      if (vehicle.films!.isEmpty) {
        for (var url in vehicle.filmsUrls!) {
          vehicle.films?.add(DataStorage().movies.firstWhere((element) => element.url == url));
        }
      }
    }

    print("Connecting starships");
    //Starships
    for(var starship in DataStorage().starships) {
      if (starship.pilots!.isEmpty) {
        for (var url in starship.pilotsUrls!) {
          starship.pilots?.add(DataStorage().characters.firstWhere((element) => element.url == url));
        }
      }

      if (starship.films!.isEmpty) {
        for (var url in starship.filmsUrls!) {
          starship.films?.add(DataStorage().movies.firstWhere((element) => element.url == url));
        }
      }
    }

    print("Connecting planets");
    //Planets
    for(var planet in DataStorage().planets) {
      if (planet.residents!.isEmpty) {
        for (var url in planet.residentsUrls!) {
          planet.residents?.add(DataStorage().characters.firstWhere((element) => element.url == url));
        }
      }

      if (planet.films!.isEmpty) {
        for (var url in planet.filmsUrls!) {
          planet.films?.add(DataStorage().movies.firstWhere((element) => element.url == url));
        }
      }
    }
    finishedLoading = true;
  }

  // Future<List<Movie>?> loadMoviesFor(String characterUrl) async{
  //   List<Movie>? movies;
  //   try {
  //     Response characterResponse = await dio.get(characterUrl);
  //     Character character = Character.fromJson(characterResponse.data);
  //     for(String filmUrl in character.moviesUrls!){
  //       getMovie(filmUrl).then((value) => movies?.add(value!));
  //     }
  //   } catch(e){
  //     print(e.toString());
  //   }
  //   return movies;
  // }
  //
  // Future<Movie?> getMovie(String url) async{
  //   try {
  //     Response movieResponse = await dio.get(url);
  //     return Movie.fromJson(movieResponse.data);
  //   } catch(e){
  //     print(e.toString());
  //   }
  // }
  //
  // Future<List<Movie>?> getMovies() async {
  //   List<Movie>? movies;
  //   try{
  //     Response res = await dio.get('https://swapi.dev/api/films');
  //     MovieResponse response = MovieResponse.fromJson(res.data);
  //     movies = response.results!;
  //     //movies.sort();
  //     for (var m in movies) {
  //       print(m.title);
  //     }
  //   } catch(e){
  //     print(e.toString());
  //   }
  //   return movies;
  // }
  //
  // Future<Character?> getCharacter(String url) async{
  //   try{
  //     Response res = await dio.get(url);
  //     return Character.fromJson(res.data);
  //   } catch(e){
  //     print("Error: $e");
  //   }
  // }
  //

  Future<Planet?> getPlanet(String url) async{
    try{
      Response res = await dio.get(url);
      return Planet.fromJson(res.data);
    } catch(e){
      print(e.toString());
    }
  }

  // Future<CharacterResponse?> getCharacters({int page = 1}) async{
  //   try{
  //     Response res = await dio.get('https://swapi.dev/api/people/?page=$page');
  //     return CharacterResponse.fromJson(res.data);
  //   } catch(e){
  //     print(e.toString());
  //   }
  // }

}