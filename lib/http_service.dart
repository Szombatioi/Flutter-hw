import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter_hf/http_data/data/character.dart';
import 'package:flutter_hf/http_data/data/movie.dart';
import 'package:flutter_hf/http_data/data/starship.dart';
import 'package:flutter_hf/http_data/data/vehicle.dart';
import 'package:flutter_hf/http_data/character_response.dart';
import 'package:get_it/get_it.dart';
import 'http_data/data/planet.dart';
import 'http_data/data/species.dart';

class HttpService {
  final Dio dio = GetIt.I<Dio>();
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

  ///### functions for characters ###
  Future<List<Movie>> loadMoviesForCharacter(Character character) async{
    List<Movie> movies = [];

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

    for(var planetUrl in movie.planetsUrls!){
      Response res = await dio.get(planetUrl);
      var planet = Planet.fromJson(res.data);
      planets.add(planet);
    }

    return planets;
  }

  Future<List<Character>> loadCharactersForMovie(Movie movie) async{
    List<Character> characters = [];

    for(var planetUrl in movie.charactersUrls!){
      Response res = await dio.get(planetUrl);
      var character = Character.fromJson(res.data);
      characters.add(character);
    }

    return characters;
  }
}