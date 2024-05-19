import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hf/http_service.dart';

import '../http_data/data/character.dart';
import '../http_data/data/movie.dart';
import '../http_data/data/planet.dart';
import '../http_data/data/species.dart';
import '../http_data/data/starship.dart';
import '../http_data/data/vehicle.dart';

class SwapiProvider with ChangeNotifier{
  final HttpService http;
  bool isLoading = false;

  List<Character> characters = [];

  //for the selected character
  List<Movie> movies = [];
  List<Species> species = [];
  List<Vehicle> vehicles = [];
  List<Starship> starships = [];
  List<Planet> planets = [];

  SwapiProvider(this.http);

  Future<void> loadCharacters() async{
    isLoading = true;
    log("Start loading characters");
    characters = await http.loadCharacters();
    isLoading = false;
    notifyListeners();
    log("End loading characters");
  }

  Future<void> loadCharacterInfo(Character character) async{
    List<Future<void>> loaders = [
      http.loadMoviesForCharacter(character).then((value) => movies = value),
      http.loadSpeciesForCharacter(character).then((value) => species = value),
      http.loadVehiclesForCharacter(character).then((value) => vehicles = value),
      http.loadStarshipsForCharacter(character).then((value) => starships = value),
    ];

    isLoading = true;
    await Future.wait(loaders);
    isLoading = false;
    
    log("${movies.length}");
    log("${species.length}");
    log("${vehicles.length}");
    log("${starships.length}");
    
    notifyListeners();
  }

  Future<void> loadMovieInfo(Movie movie) async{
    List<Future<void>> loaders = [
      http.loadCharactersForMovie(movie).then((value) => characters = value),
      http.loadSpeciesForMovie(movie).then((value) => species = value),
      http.loadVehiclesForMovie(movie).then((value) => vehicles = value),
      http.loadStarshipsForMovie(movie).then((value) => starships = value),
    ];

    isLoading = true;
    await Future.wait(loaders);
    isLoading = false;
  }

  Future<bool> assetExists(String path) async{
    path = path.split(' ').join();
    try {
      await rootBundle.load(path);
      return true;
    } catch(_) {
      return false;
    }
  }
}