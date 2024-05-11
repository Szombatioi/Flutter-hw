import 'package:flutter_hf/http_communication.dart';
import 'package:flutter_hf/http_data/data/species.dart';
import 'package:flutter_hf/http_data/data/starship.dart';
import 'package:flutter_hf/http_data/data/vehicle.dart';
import 'package:flutter_hf/http_data/data_storage.dart';

import 'movie.dart';

class Character {
  String? name;
  String? height;
  String? mass;
  String? hairColor;
  String? skinColor;
  String? eyeColor;
  String? birthYear;
  String? gender;
  String? homeworld;
  List<Movie>? movies;
  List<Species>? species;
  List<Vehicle>? vehicles;
  List<Starship>? starships;
  String? created;
  String? edited;
  String? url;

  Character({
    this.name,
    this.height,
    this.mass,
    this.hairColor,
    this.skinColor,
    this.eyeColor,
    this.birthYear,
    this.gender,
    this.homeworld,
    this.movies,
    this.species,
    this.vehicles,
    this.starships,
    this.created,
    this.edited,
    this.url,});

  Character.fromJson(dynamic json) {
    name = json['name'];
    height = json['height'];
    mass = json['mass'];
    hairColor = json['hair_color'];
    skinColor = json['skin_color'];
    eyeColor = json['eye_color'];
    birthYear = json['birth_year'];
    gender = json['gender'];
    homeworld = json['homeworld'];

    //Binding the movies to the character. We need to make sure, that the DataStorage is filled before this!
    if (json['films'] != null) {
      movies = [];
      json['films'].forEach((v) {
        if(DataStorage().movies.isEmpty){
          //get all movies
        }
        movies?.add(DataStorage().movies.firstWhere((element) => element.url == v));
      });
    }

    if (json['species'] != null) {
      species = [];
      json['species'].forEach((v) {
        if(DataStorage().species.isEmpty){
          //get all species
        }
        species?.add(DataStorage().species.firstWhere((element) => element.url == v));
      });
    }

    if (json['vehicles'] != null) {
      vehicles = [];
      json['vehicles'].forEach((v) {
        if(DataStorage().vehicles.isEmpty){
          //get all vehicles
        }
        vehicles?.add(DataStorage().vehicles.firstWhere((element) => element.url == v));
      });
    }

    if (json['starships'] != null) {
      starships = [];
      json['starships'].forEach((v) {
        if(DataStorage().starships.isEmpty){
          //get all starships
        }
        starships?.add(DataStorage().starships.firstWhere((element) => element.url == v));
      });
    }
    created = json['created'];
    edited = json['edited'];
    url = json['url'];
  }
}