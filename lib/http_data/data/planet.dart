import 'package:flutter_hf/http_data/data/character.dart';
import 'package:flutter_hf/http_data/data/movie.dart';

import '../data_storage.dart';

class Planet {
  String? name;
  String? rotationPeriod;
  String? orbitalPeriod;
  String? diameter;
  String? climate;
  String? gravity;
  String? terrain;
  String? surfaceWater;
  String? population;

  List<String>? residentsUrls;
  List<String>? filmsUrls;
  List<Character>? residents;
  List<Movie>? films;

  String? created;
  String? edited;
  String? url;

  Planet(
      {this.name,
        this.rotationPeriod,
        this.orbitalPeriod,
        this.diameter,
        this.climate,
        this.gravity,
        this.terrain,
        this.surfaceWater,
        this.population,
        this.residents,
        this.films,
        this.created,
        this.edited,
        this.url});

  Planet.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    rotationPeriod = json['rotation_period'];
    orbitalPeriod = json['orbital_period'];
    diameter = json['diameter'];
    climate = json['climate'];
    gravity = json['gravity'];
    terrain = json['terrain'];
    surfaceWater = json['surface_water'];
    population = json['population'];

    residentsUrls = json['residents'].cast<String>();
    residents = [];
    filmsUrls = json['films'].cast<String>();
    films = [];

    // if (json['residents'] != null) {
    //   residents = [];
    //   json['films'].forEach((v) {
    //     if(DataStorage().characters.isEmpty){
    //       //get all characters
    //     }
    //     residents?.add(DataStorage().characters.firstWhere((element) => element.url == v));
    //   });
    // }
    //
    // if (json['films'] != null) {
    //   films = [];
    //   json['films'].forEach((v) {
    //     if(DataStorage().movies.isEmpty){
    //       //get all characters
    //     }
    //     films?.add(DataStorage().movies.firstWhere((element) => element.url == v));
    //   });
    // }


    created = json['created'];
    edited = json['edited'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['rotation_period'] = this.rotationPeriod;
    data['orbital_period'] = this.orbitalPeriod;
    data['diameter'] = this.diameter;
    data['climate'] = this.climate;
    data['gravity'] = this.gravity;
    data['terrain'] = this.terrain;
    data['surface_water'] = this.surfaceWater;
    data['population'] = this.population;
    data['residents'] = this.residents;
    data['films'] = this.films;
    data['created'] = this.created;
    data['edited'] = this.edited;
    data['url'] = this.url;
    return data;
  }
}