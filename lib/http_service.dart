import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter_hf/http_data/data_storage.dart';
import 'package:flutter_hf/http_data/movie_response.dart';
import 'package:flutter_hf/http_data/character_response.dart';
import 'package:flutter_hf/http_data/planet_response.dart';
import 'package:flutter_hf/http_data/species_response.dart';
import 'package:get_it/get_it.dart';
import 'http_data/data/planet.dart';
import 'http_data/starship_response.dart';
import 'http_data/vehicle_response.dart';

class HttpService {
  final Dio dio = GetIt.I<Dio>();
  final DataStorage dataStorage = GetIt.I<DataStorage>();
  bool finishedLoading = false;

  HttpService(){
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (HttpClient client) {
      client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
      return client;
    };
  }

  Future<void> loadCharacters() async{
    print("Characters loading");
    int page = 1;
    bool run = true;
    while(run){
      try{
        Response res = await dio.get('https://swapi.dev/api/people/?page=${page++}');
        CharacterResponse characterResponse = CharacterResponse.fromJson(res.data);
        dataStorage.characters.addAll(characterResponse.results!);
      } catch(e){
        run = false;
      }
    }
    // print("Character count: ${dataStorage.characters.length}");
    // for (var element in dataStorage.characters) {print(element.url);}
  }

  Future<void> loadMovies() async {
    print("Movies loading");
    Response res = await dio.get('https://swapi.dev/api/films');
    MovieResponse movieResponse = MovieResponse.fromJson(res.data);
    dataStorage.movies.addAll(movieResponse.results!);
    // print("Movies count: ${dataStorage.movies.length}");
    // for (var element in dataStorage.movies) {print(element.url);}
  }

  Future<void> loadPlanets() async {
    print("Planets loading");
    bool run = true;
    int page = 1;
    while(run){
      try{
        Response res = await dio.get('https://swapi.dev/api/planets/?page=${page++}');
        PlanetResponse planetResponse = PlanetResponse.fromJson(res.data!);
        dataStorage.planets.addAll(planetResponse.results!);
      } catch(e){
        //print(e);
        run = false;
      }
    }
    // print("Planets count: ${dataStorage.planets.length}");
    // for (var element in dataStorage.planets) {print(element.url);}
  }

  Future<void> loadSpecies() async{
    print("Species loading");
    bool run = true;
    int page = 1;
    while(run){
      try{
        Response res = await dio.get('https://swapi.dev/api/species/?page=${page++}');
        SpeciesResponse speciesResponse = SpeciesResponse.fromJson(res.data);
        dataStorage.species.addAll(speciesResponse.results!);
      } catch(e){
        print(e);
        run = false;
      }
    }
    // print("Species count: ${dataStorage.species.length}");
    // for (var element in dataStorage.species) {print(element.url);}
  }

  Future<void> loadStarships() async{
    print("Starships loading");
    bool run = true;
    int page = 1;
    while(run){
      try{
        Response res = await dio.get('https://swapi.dev/api/starships/?page=${page++}');
        StarshipsResponse starshipsResponse = StarshipsResponse.fromJson(res.data);
        dataStorage.starships.addAll(starshipsResponse.results!);
      } catch(e){
        run = false;
      }
    }
    // print("Starships count: ${dataStorage.starships.length}");
    // for (var element in dataStorage.starships) {print(element.url);}
  }

  Future<void> loadVehicles() async{
    print("Vehicles loading");
    bool run = true;
    int page = 1;
    while(run){
      try{
        Response res = await dio.get('https://swapi.dev/api/vehicles/?page=${page++}');
        VehicleResponse vehicleResponse = VehicleResponse.fromJson(res.data);
        dataStorage.vehicles.addAll(vehicleResponse.results!);
      } catch(e){
        run = false;
      }
    }
    // print("Vehicles count: ${dataStorage.vehicles.length}");
    // for (var element in dataStorage.vehicles) {print(element.url);}
  }

  Future<void> startLoading() async{
    List<Future<void>> loaders = [
      loadCharacters(),
      loadMovies(),
      loadPlanets(),
      loadSpecies(),
      loadStarships(),
      loadVehicles()
    ];

    await Future.wait(loaders);


    print("###Connecting lists###");
    print("Connecting characters");
    //Characters
    for(var character in dataStorage.characters){
      if(character.homeworld == null){
        getPlanet(character.homeworldUrl!).then((value) => character.homeworld = value);
      }
      if(character.movies.isEmpty){
        for(var url in character.moviesUrls!){
          character.movies.add(dataStorage.movies.firstWhere((element) => element.url == url));
        }
      }

      if(character.vehicles.isEmpty){
        for(var url in character.vehiclesUrls!){
          character.vehicles.add(dataStorage.vehicles.firstWhere((element) => element.url == url));
        }
      }

      if(character.species.isEmpty){
        for(var url in character.speciesUrls!){
          character.species.add(dataStorage.species.firstWhere((element) => element.url == url));
        }
      }

      if(character.starships.isEmpty){
        for(var url in character.starshipsUrls!){
          character.starships.add(dataStorage.starships.firstWhere((element) => element.url == url));
        }
      }
    }

    print("Connecting movies");
    //Movies - characters, planets, starships, vehicles, species
    for(var movie in dataStorage.movies){
      if(movie.characters!.isEmpty){
        try{
          for(var url in movie.charactersUrls!){
            movie.characters?.add(dataStorage.characters.firstWhere((element) => element.url == url));
          }
        }catch(e){
          print("Error was here: $e");
        }
      }

      if(movie.planets!.isEmpty){
        try{
        for(var url in movie.planetsUrls!){
          movie.planets?.add(dataStorage.planets.firstWhere((element) => element.url == url));
        }}catch(e){
          print("Error: $e");
        }
      }

      if(movie.starships!.isEmpty){
        try{
        for(var url in movie.starshipsUrls!){
          movie.starships?.add(dataStorage.starships.firstWhere((element) => element.url == url));
        }}catch(e){
          print("Error: $e");
        }
      }

      if(movie.vehicles!.isEmpty){
        try{
        for(var url in movie.vehiclesUrls!){
          movie.vehicles?.add(dataStorage.vehicles.firstWhere((element) => element.url == url));
        }}catch(e){
          print("Error: $e");
        }
      }

      if(movie.species!.isEmpty){
        try{
        for(var url in movie.speciesUrls!){
          movie.species?.add(dataStorage.species.firstWhere((element) => element.url == url));
        }}catch(e){
          print("Error: $e");
        }
      }
    }

    print("Connecting species");
    //Species - films, people
    for(var species in dataStorage.species) {
      if (species.people!.isEmpty) {
        for (var url in species.peopleUrls!) {
          species.people?.add(
              dataStorage.characters.firstWhere((element) => element.url == url));
        }
      }

      if (species.films!.isEmpty) {
        for (var url in species.filmsUrls!) {
          species.films?.add(
              dataStorage.movies.firstWhere((element) => element.url == url));
        }
      }
    }

    print("Connecting vehicles");
    //Vehicles - films, pilots
    for(var vehicle in dataStorage.vehicles) {
      if (vehicle.pilots!.isEmpty) {
        for (var url in vehicle.pilotsUrls!) {
          vehicle.pilots?.add(dataStorage.characters.firstWhere((element) => element.url == url));
        }
      }

      if (vehicle.films!.isEmpty) {
        for (var url in vehicle.filmsUrls!) {
          vehicle.films?.add(dataStorage.movies.firstWhere((element) => element.url == url));
        }
      }
    }

    print("Connecting starships");
    //Starships
    for(var starship in dataStorage.starships) {
      if (starship.pilots!.isEmpty) {
        for (var url in starship.pilotsUrls!) {
          starship.pilots?.add(dataStorage.characters.firstWhere((element) => element.url == url));
        }
      }

      if (starship.films!.isEmpty) {
        for (var url in starship.filmsUrls!) {
          starship.films?.add(dataStorage.movies.firstWhere((element) => element.url == url));
        }
      }
    }

    print("Connecting planets");
    //Planets
    for(var planet in dataStorage.planets) {
      if (planet.residents!.isEmpty) {
        for (var url in planet.residentsUrls!) {
          planet.residents?.add(dataStorage.characters.firstWhere((element) => element.url == url));
        }
      }

      if (planet.films!.isEmpty) {
        for (var url in planet.filmsUrls!) {
          planet.films?.add(dataStorage.movies.firstWhere((element) => element.url == url));
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