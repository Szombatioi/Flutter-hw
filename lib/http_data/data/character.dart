import 'package:flutter_hf/http_communication.dart';
import 'package:flutter_hf/http_data/data/planet.dart';
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
  Planet? homeworld;
  String? homeworldUrl;

  //For lazy loading. We store the urls as strings and if we really need them, we load the actual lists
  List<String>? moviesUrls;
  List<Movie> movies = [];
  List<String>? speciesUrls;
  List<Species> species = [];
  List<String>? vehiclesUrls;
  List<Vehicle> vehicles = [];
  List<String>? starshipsUrls;
  List<Starship> starships = [];

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
    this.movies = const [],
    this.species = const [],
    this.vehicles = const [],
    this.starships = const [],
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

    homeworldUrl = json['homeworld'];

    moviesUrls = json['films'].cast<String>();
    movies = [];
    speciesUrls = json['species'].cast<String>();
    species = [];
    vehiclesUrls = json['vehicles'].cast<String>();
    vehicles = [];
    starshipsUrls = json['starships'].cast<String>();
    starships = [];

    //Binding the movies to the character. We need to make sure, that the DataStorage is filled before this!
    // if (json['films'] != null) {
    //   movies = [];
    //   json['films'].forEach((v) {
    //     if(DataStorage().movies.isEmpty){
    //       //get all movies
    //     }
    //     movies?.add(DataStorage().movies.firstWhere((element) => element.url == v));
    //   });
    // }
    //
    // if (json['species'] != null) {
    //   species = [];
    //   json['species'].forEach((v) {
    //     if(DataStorage().species.isEmpty){
    //       //get all species
    //     }
    //     species?.add(DataStorage().species.firstWhere((element) => element.url == v));
    //   });
    // }
    //
    // if (json['vehicles'] != null) {
    //   vehicles = [];
    //   json['vehicles'].forEach((v) {
    //     if(DataStorage().vehicles.isEmpty){
    //       //get all vehicles
    //     }
    //     vehicles?.add(DataStorage().vehicles.firstWhere((element) => element.url == v));
    //   });
    // }
    //
    // if (json['starships'] != null) {
    //   starships = [];
    //   json['starships'].forEach((v) {
    //     if(DataStorage().starships.isEmpty){
    //       //get all starships
    //     }
    //     starships?.add(DataStorage().starships.firstWhere((element) => element.url == v));
    //   });
    // }
    created = json['created'];
    edited = json['edited'];
    url = json['url'];

    // //TODO tegyük át karakteroldalra
    // information = [];
    // for (var key in json.keys) {
    //   var value = json[key];
    //   if (value != null && value is String && !["created", "edited", "url", "homeworld"].contains(key)) information.add(value);
    // }
    // information.add(homeworld!.name!);

  }
}