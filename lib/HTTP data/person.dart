import 'film.dart';

class Person {
  String? name;
  String? height;
  String? mass;
  String? hairColor;
  String? skinColor;
  String? eyeColor;
  String? birthYear;
  String? gender;
  String? homeworld;
  List<String>? films;
  List<String>? species;
  List<String>? vehicles;
  List<String>? starships;
  String? created;
  String? edited;
  String? url;

  Person({
    this.name,
    this.height,
    this.mass,
    this.hairColor,
    this.skinColor,
    this.eyeColor,
    this.birthYear,
    this.gender,
    this.homeworld,
    this.films,
    this.species,
    this.vehicles,
    this.starships,
    this.created,
    this.edited,
    this.url,});

  Person.fromJson(dynamic json) {
    name = json['name'];
    height = json['height'];
    mass = json['mass'];
    hairColor = json['hair_color'];
    skinColor = json['skin_color'];
    eyeColor = json['eye_color'];
    birthYear = json['birth_year'];
    gender = json['gender'];
    homeworld = json['homeworld'];

    if (json['films'] != null) {
      films = [];
      json['films'].forEach((v) {
        films?.add(v.toString());
      });
    }

    if (json['species'] != null) {
      species = [];
      json['species'].forEach((v) {
        species?.add(v.toString());
      });
    }
    vehicles = json['vehicles'] != null ? json['vehicles'].cast<String>() : [];
    starships = json['starships'] != null ? json['starships'].cast<String>() : [];
    created = json['created'];
    edited = json['edited'];
    url = json['url'];
  }

  Person copyWith({  String? name,
    String? height,
    String? mass,
    String? hairColor,
    String? skinColor,
    String? eyeColor,
    String? birthYear,
    String? gender,
    String? homeworld,
    List<String>? films,
    List<String>? species,
    List<String>? vehicles,
    List<String>? starships,
    String? created,
    String? edited,
    String? url,
  }) => Person(  name: name ?? this.name,
    height: height ?? this.height,
    mass: mass ?? this.mass,
    hairColor: hairColor ?? this.hairColor,
    skinColor: skinColor ?? this.skinColor,
    eyeColor: eyeColor ?? this.eyeColor,
    birthYear: birthYear ?? this.birthYear,
    gender: gender ?? this.gender,
    homeworld: homeworld ?? this.homeworld,
    films: films ?? this.films,
    species: species ?? this.species,
    vehicles: vehicles ?? this.vehicles,
    starships: starships ?? this.starships,
    created: created ?? this.created,
    edited: edited ?? this.edited,
    url: url ?? this.url,
  );
}