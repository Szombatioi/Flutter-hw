import 'package:flutter_hf/http_data/data/planet.dart';
import 'package:flutter_hf/http_data/data/starship.dart';

import 'data/character.dart';
import 'data/movie.dart';
import 'data/species.dart';
import 'data/vehicle.dart';

/// Singleton class to store all elements we need.
class DataStorage{
  static final DataStorage _singleton = DataStorage._internal();

  factory DataStorage(){
    return _singleton;
  }

  DataStorage._internal();


  //Lists of elements
  List<Character> characters = [];
  List<Movie> movies = [];
  List<Species> species = [];
  List<Vehicle> vehicles = [];
  List<Starship> starships = [];
  List<Planet> planets = [];
}
