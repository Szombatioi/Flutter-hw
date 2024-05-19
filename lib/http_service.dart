import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter_hf/http_data/data/character.dart';
import 'package:flutter_hf/http_data/data/movie.dart';
import 'package:flutter_hf/http_data/data/starship.dart';
import 'package:flutter_hf/http_data/data/vehicle.dart';
import 'package:flutter_hf/http_data/data_storage.dart';
import 'package:flutter_hf/http_data/movie_response.dart';
import 'package:flutter_hf/http_data/character_response.dart';
import 'package:flutter_hf/http_data/planet_response.dart';
import 'package:flutter_hf/http_data/species_response.dart';
import 'package:get_it/get_it.dart';
import 'http_data/data/planet.dart';
import 'http_data/data/species.dart';
import 'http_data/starship_response.dart';
import 'http_data/vehicle_response.dart';

class HttpService {
  final Dio dio = GetIt.I<Dio>();
  final DataStorage dataStorage = GetIt.I<DataStorage>();
  final String baseUrl = "https://swapi.dev/api/";
  bool finishedLoading = false;

  HttpService(){
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (HttpClient client) {
      client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
      return client;
    };
  }

  
  Future<List<Character>> loadCharacters() async{
    List<Character> characters = [];
    int page = 1;
    bool run = true;
    while(run){
      Response res = await dio.get('${baseUrl}people/?page=${page++}');
      CharacterResponse characterResponse = CharacterResponse.fromJson(res.data);
      //dataStorage.characters.addAll(characterResponse.results!);
      characters.addAll(characterResponse.results!);
      if(characterResponse.next == null) run = false;
    }
    return characters;
  }

  Future<List<Movie>> loadMoviesForCharacter(Character character) async{
    List<Movie> movies = [];
    // Response charRes = await dio.get(characterUrl);
    // Character character = Character.fromJson(charRes.data);

    for(var movieUrl in character.moviesUrls!){
      log("Movie: $movieUrl");
      Response res = await dio.get(movieUrl);
      var movie = Movie.fromJson(res.data);
      movies.add(movie);
    }

    return movies;
  }

  Future<List<Species>> loadSpeciesForCharacter(Character character) async{
    List<Species> species = [];
    // Response charRes = await dio.get(characterUrl);
    // Character character = Character.fromJson(charRes.data);

    for(var speciesUrl in character.speciesUrls!){
      log("Species: $speciesUrl");
      Response res = await dio.get(speciesUrl);
      var species_ = Species.fromJson(res.data);
      species.add(species_);
    }
    return species;
  }

  Future<List<Vehicle>> loadVehiclesForCharacter(Character character) async{
    List<Vehicle> vehicles = [];
    // Response charRes = await dio.get(characterUrl);
    // Character character = Character.fromJson(charRes.data);

    for(var vehicleUrl in character.vehiclesUrls!){
      log("Vehicle: $vehicleUrl");
      Response res = await dio.get(vehicleUrl);
      var vehicle = Vehicle.fromJson(res.data);
      vehicles.add(vehicle);
    }
    return vehicles;
  }

  Future<List<Starship>> loadStarshipsForCharacter(Character character) async{
    List<Starship> starships = [];
    // Response charRes = await dio.get(characterUrl);
    // Character character = Character.fromJson(charRes.data);

    for(var starshipUrl in character.starshipsUrls!){
      log("Starship: $starshipUrl");
      Response res = await dio.get(starshipUrl);
      var starship = Starship.fromJson(res.data);
      starships.add(starship);
    }

    return starships;
  }

  ///### functions for movies ###
  Future<List<Species>> loadSpeciesForMovie(Movie movie) async{
    List<Species> species = [];
    // Response charRes = await dio.get(movieUrl);
    // movie movie = movie.fromJson(charRes.data);

    for(var speciesUrl in movie.speciesUrls!){
      log("Species: $speciesUrl");
      Response res = await dio.get(speciesUrl);
      var species_ = Species.fromJson(res.data);
      species.add(species_);
    }
    return species;
  }

  Future<List<Vehicle>> loadVehiclesForMovie(Movie movie) async{
    List<Vehicle> vehicles = [];
    // Response charRes = await dio.get(movieUrl);
    // Character movie = Character.fromJson(charRes.data);

    for(var vehicleUrl in movie.vehiclesUrls!){
      log("Vehicle: $vehicleUrl");
      Response res = await dio.get(vehicleUrl);
      var vehicle = Vehicle.fromJson(res.data);
      vehicles.add(vehicle);
    }
    return vehicles;
  }

  Future<List<Starship>> loadStarshipsForMovie(Movie movie) async{
    List<Starship> starships = [];
    // Response charRes = await dio.get(movieUrl);
    // Character movie = Character.fromJson(charRes.data);

    for(var starshipUrl in movie.starshipsUrls!){
      log("Starship: $starshipUrl");
      Response res = await dio.get(starshipUrl);
      var starship = Starship.fromJson(res.data);
      starships.add(starship);
    }

    return starships;
  }

  Future<List<Planet>> loadPlanetsForMovie(Movie movie) async{
    List<Planet> planets = [];
    // Response charRes = await dio.get(movieUrl);
    // Character movie = Character.fromJson(charRes.data);

    for(var planetUrl in movie.planetsUrls!){
      Response res = await dio.get(planetUrl);
      var planet = Planet.fromJson(res.data);
      planets.add(planet);
    }

    return planets;
  }

  Future<List<Character>> loadCharactersForMovie(Movie movie) async{
    List<Character> characters = [];
    // Response charRes = await dio.get(movieUrl);
    // Character movie = Character.fromJson(charRes.data);

    for(var planetUrl in movie.charactersUrls!){
      Response res = await dio.get(planetUrl);
      var character = Character.fromJson(res.data);
      characters.add(character);
    }

    return characters;
  }











  Future<void> loadMovies() async {
    log("Movies loading");
    int page = 1;
    bool run = true;
    while(run) {
      Response res = await dio.get('${baseUrl}films/?page=${page++}');
      MovieResponse movieResponse = MovieResponse.fromJson(res.data);
      dataStorage.movies.addAll(movieResponse.results!);
      if(movieResponse.next == null) run = false;
    }
    // log("Movies count: ${dataStorage.movies.length}");
    // for (var element in dataStorage.movies) {log(element.url);}
  }

  Future<void> loadPlanets() async {
    log("Planets loading");
    int page = 1;
    bool run = true;
    while(run){
      Response res = await dio.get('${baseUrl}planets/?page=${page++}');
      PlanetResponse planetResponse = PlanetResponse.fromJson(res.data!);
      dataStorage.planets.addAll(planetResponse.results!);
      if(planetResponse.next == null) run = false;
    }
    // log("Planets count: ${dataStorage.planets.length}");
    // for (var element in dataStorage.planets) {log(element.url);}
  }

  Future<void> loadSpecies() async{
    log("Species loading");
    int page = 1;
    bool run = true;
    while(run){
      Response res = await dio.get('${baseUrl}species/?page=${page++}');
      SpeciesResponse speciesResponse = SpeciesResponse.fromJson(res.data);
      dataStorage.species.addAll(speciesResponse.results!);
      if(speciesResponse.next == null) run = false;
    }
    // log("Species count: ${dataStorage.species.length}");
    // for (var element in dataStorage.species) {log(element.url);}
  }

  Future<void> loadStarships() async{
    log("Starships loading");
    int page = 1;
    bool run = true;
    while(run){
      Response res = await dio.get('${baseUrl}starships/?page=${page++}');
      StarshipsResponse starshipsResponse = StarshipsResponse.fromJson(res.data);
      dataStorage.starships.addAll(starshipsResponse.results!);
      if(starshipsResponse.next == null) run = false;
    }
    // log("Starships count: ${dataStorage.starships.length}");
    // for (var element in dataStorage.starships) {log(element.url);}
  }

  Future<void> loadVehicles() async{
    log("Vehicles loading");
    int page = 1;
    bool run = true;
    while(run){
      Response res = await dio.get('${baseUrl}vehicles/?page=${page++}');
      VehicleResponse vehicleResponse = VehicleResponse.fromJson(res.data);
      dataStorage.vehicles.addAll(vehicleResponse.results!);
      if(vehicleResponse.next == null) run = false;
    }
    // log("Vehicles count: ${dataStorage.vehicles.length}");
    // for (var element in dataStorage.vehicles) {log(element.url);}
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


    
    log("###Connecting lists###");
    log("Connecting characters");
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

    log("Connecting movies");
    //Movies - characters, planets, starships, vehicles, species
    for(var movie in dataStorage.movies){
      if(movie.characters!.isEmpty){
        try{
          for(var url in movie.charactersUrls!){
            movie.characters?.add(dataStorage.characters.firstWhere((element) => element.url == url));
          }
        }catch(e){
          log("Error was here: $e");
        }
      }

      if(movie.planets!.isEmpty){
        try{
        for(var url in movie.planetsUrls!){
          movie.planets?.add(dataStorage.planets.firstWhere((element) => element.url == url));
        }}catch(e){
          log("Error: $e");
        }
      }

      if(movie.starships!.isEmpty){
        try{
        for(var url in movie.starshipsUrls!){
          movie.starships?.add(dataStorage.starships.firstWhere((element) => element.url == url));
        }}catch(e){
          log("Error: $e");
        }
      }

      if(movie.vehicles!.isEmpty){
        try{
        for(var url in movie.vehiclesUrls!){
          movie.vehicles?.add(dataStorage.vehicles.firstWhere((element) => element.url == url));
        }}catch(e){
          log("Error: $e");
        }
      }

      if(movie.species!.isEmpty){
        try{
        for(var url in movie.speciesUrls!){
          movie.species?.add(dataStorage.species.firstWhere((element) => element.url == url));
        }}catch(e){
          log("Error: $e");
        }
      }
    }

    log("Connecting species");
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

    log("Connecting vehicles");
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

    log("Connecting starships");
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

    log("Connecting planets");
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
  //     log(e.toString());
  //   }
  //   return movies;
  // }
  //
  // Future<Movie?> getMovie(String url) async{
  //   try {
  //     Response movieResponse = await dio.get(url);
  //     return Movie.fromJson(movieResponse.data);
  //   } catch(e){
  //     log(e.toString());
  //   }
  // }
  //
  // Future<List<Movie>?> getMovies() async {
  //   List<Movie>? movies;
  //   try{
  //     Response res = await dio.get('${baseUrl}films');
  //     MovieResponse response = MovieResponse.fromJson(res.data);
  //     movies = response.results!;
  //     //movies.sort();
  //     for (var m in movies) {
  //       log(m.title);
  //     }
  //   } catch(e){
  //     log(e.toString());
  //   }
  //   return movies;
  // }
  //
  // Future<Character?> getCharacter(String url) async{
  //   try{
  //     Response res = await dio.get(url);
  //     return Character.fromJson(res.data);
  //   } catch(e){
  //     log("Error: $e");
  //   }
  // }
  //

  Future<Planet?> getPlanet(String url) async{
    try{
      Response res = await dio.get(url);
      return Planet.fromJson(res.data);
    } catch(e){
      log(e.toString());
    }
  }

  // Future<CharacterResponse?> getCharacters({int page = 1}) async{
  //   try{
  //     Response res = await dio.get('${baseUrl}people/?page=$page');
  //     return CharacterResponse.fromJson(res.data);
  //   } catch(e){
  //     log(e.toString());
  //   }
  // }

}