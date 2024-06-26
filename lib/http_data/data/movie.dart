import 'package:flutter_hf/http_data/data/character.dart';
import 'package:flutter_hf/http_data/data/planet.dart';
import 'package:flutter_hf/http_data/data/species.dart';
import 'package:flutter_hf/http_data/data/starship.dart';
import 'package:flutter_hf/http_data/data/vehicle.dart';

class Movie {
  String? title;
  num? episodeId;
  String? openingCrawl;
  String? director;
  String? producer;
  String? releaseDate;

  List<String>? charactersUrls;
  List<Character>? characters;
  List<String>? planetsUrls;
  List<Planet>? planets;
  List<String>? starshipsUrls;
  List<Starship>? starships;
  List<String>? vehiclesUrls;
  List<Vehicle>? vehicles;
  List<String>? speciesUrls;
  List<Species>? species;

  String? created;
  String? edited;
  String? url;

  Movie({
      this.title, 
      this.episodeId, 
      this.openingCrawl, 
      this.director, 
      this.producer, 
      this.releaseDate, 
      this.characters, 
      this.planets, 
      this.starships, 
      this.vehicles, 
      this.species, 
      this.created, 
      this.edited, 
      this.url,});

  Movie.fromJson(dynamic json) {
    title = json['title'];
    episodeId = json['episode_id'];
    openingCrawl = json['opening_crawl'];
    director = json['director'];
    producer = json['producer'];
    releaseDate = json['release_date'];

    planetsUrls = json['planets'].cast<String>();
    planets = [];
    charactersUrls = json['characters'].cast<String>();
    characters = [];
    speciesUrls = json['species'].cast<String>();
    species = [];
    vehiclesUrls = json['vehicles'].cast<String>();
    vehicles = [];
    starshipsUrls = json['starships'].cast<String>();
    starships = [];

    // if (json['characters'] != null) {
    //   characters = [];
    //   json['characters'].forEach((v) {
    //     if(DataStorage().characters.isEmpty){
    //       //get all characters
    //     }
    //     characters?.add(DataStorage().characters.firstWhere((element) => element.url == v));
    //   });
    // }
    //
    // if (json['planets'] != null) {
    //   planets = [];
    //   json['planets'].forEach((v) {
    //     if(DataStorage().planets.isEmpty){
    //       //get all characters
    //     }
    //     planets?.add(DataStorage().planets.firstWhere((element) => element.url == v));
    //   });
    // }
    //
    // if (json['starships'] != null) {
    //   starships = [];
    //   json['starships'].forEach((v) {
    //     if(DataStorage().starships.isEmpty){
    //       //get all characters
    //     }
    //     starships?.add(DataStorage().starships.firstWhere((element) => element.url == v));
    //   });
    // }
    //
    // if (json['vehicles'] != null) {
    //   vehicles = [];
    //   json['vehicles'].forEach((v) {
    //     if(DataStorage().vehicles.isEmpty){
    //       //get all characters
    //     }
    //     vehicles?.add(DataStorage().vehicles.firstWhere((element) => element.url == v));
    //   });
    // }
    //
    // if (json['species'] != null) {
    //   species = [];
    //   json['species'].forEach((v) {
    //     if(DataStorage().species.isEmpty){
    //       //get all characters
    //     }
    //     species?.add(DataStorage().species.firstWhere((element) => element.url == v));
    //   });
    // }

    created = json['created'];
    edited = json['edited'];
    url = json['url'];
  }
}