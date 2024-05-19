import 'package:flutter_hf/http_data/data/planet.dart';
import 'package:flutter_hf/http_data/data/species.dart';
import 'package:flutter_hf/http_data/data/starship.dart';
import 'package:flutter_hf/http_data/data/vehicle.dart';

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
    created = json['created'];
    edited = json['edited'];
    url = json['url'];
  }
}