import 'package:flutter_hf/http_data/data/character.dart';
import 'package:flutter_hf/http_data/data/movie.dart';

import '../data_storage.dart';

class Starship {
  String? name;
  String? model;
  String? manufacturer;
  String? costInCredits;
  String? length;
  String? maxAtmospheringSpeed;
  String? crew;
  String? passengers;
  String? cargoCapacity;
  String? consumables;
  String? hyperdriveRating;
  String? mGLT;
  String? starshipClass;
  List<Character>? pilots;
  List<Movie>? films;
  String? created;
  String? edited;
  String? url;

  Starship(
      {this.name,
        this.model,
        this.manufacturer,
        this.costInCredits,
        this.length,
        this.maxAtmospheringSpeed,
        this.crew,
        this.passengers,
        this.cargoCapacity,
        this.consumables,
        this.hyperdriveRating,
        this.mGLT,
        this.starshipClass,
        this.pilots,
        this.films,
        this.created,
        this.edited,
        this.url});

  Starship.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    model = json['model'];
    manufacturer = json['manufacturer'];
    costInCredits = json['cost_in_credits'];
    length = json['length'];
    maxAtmospheringSpeed = json['max_atmosphering_speed'];
    crew = json['crew'];
    passengers = json['passengers'];
    cargoCapacity = json['cargo_capacity'];
    consumables = json['consumables'];
    hyperdriveRating = json['hyperdrive_rating'];
    mGLT = json['MGLT'];
    starshipClass = json['starship_class'];

    if (json['films'] != null) {
      films = [];
      json['films'].forEach((v) {
        if(DataStorage().movies.isEmpty){
          //get all movies
        }
        films?.add(DataStorage().movies.firstWhere((element) => element.url == v));
      });
    }

    if (json['pilots'] != null) {
      pilots = [];
      json['pilots'].forEach((v) {
        if(DataStorage().characters.isEmpty){
          //get all movies
        }
        pilots?.add(DataStorage().characters.firstWhere((element) => element.url == v));
      });
    }

    created = json['created'];
    edited = json['edited'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =<String, dynamic>{};
    data['name'] = name;
    data['model'] = model;
    data['manufacturer'] = manufacturer;
    data['cost_in_credits'] = costInCredits;
    data['length'] = length;
    data['max_atmosphering_speed'] = maxAtmospheringSpeed;
    data['crew'] = crew;
    data['passengers'] = passengers;
    data['cargo_capacity'] = cargoCapacity;
    data['consumables'] = consumables;
    data['hyperdrive_rating'] = hyperdriveRating;
    data['MGLT'] = mGLT;
    data['starship_class'] = starshipClass;
    data['pilots'] = pilots;
    data['films'] = films;
    data['created'] = created;
    data['edited'] = edited;
    data['url'] = url;
    return data;
  }
}