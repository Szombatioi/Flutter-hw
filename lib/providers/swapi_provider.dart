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
    log("Character: ${character.name}");
    isLoading = true;
    log("Loading movies for character");
    movies = await http.loadMoviesForCharacter(character);
    log("Loading species for character");
    species = await http.loadSpeciesForCharacter(character);
    log("Loading vehicles for character");
    vehicles = await http.loadVehiclesForCharacter(character);
    log("Loading starships for character");
    starships = await http.loadStarshipsForCharacter(character);
    isLoading = false;
    
    log("${movies.length}");
    log("${species.length}");
    log("${vehicles.length}");
    log("${starships.length}");
    
    notifyListeners();
  }

  Future<void> loadMovieInfo(Movie movie) async{
    isLoading = true;
    characters = await http.loadCharactersForMovie(movie);
    log("Loading species for character");
    species = await http.loadSpeciesForMovie(movie);
    log("Loading vehicles for character");
    vehicles = await http.loadVehiclesForMovie(movie);
    log("Loading starships for character");
    starships = await http.loadStarshipsForMovie(movie);
    isLoading = false;
    log("Finished loading movie info");
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