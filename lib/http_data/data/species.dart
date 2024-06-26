import 'package:flutter_hf/http_data/data/character.dart';
import 'package:flutter_hf/http_data/data/movie.dart';

class Species {
  String? name;
  String? classification;
  String? designation;
  String? averageHeight;
  String? skinColors;
  String? hairColors;
  String? eyeColors;
  String? averageLifespan;
  String? homeworld;
  String? language;
  List<Character>? people;
  List<Movie>? films;
  List<String>? peopleUrls;
  List<String>? filmsUrls;
  String? created;
  String? edited;
  String? url;

  Species(
      {this.name,
        this.classification,
        this.designation,
        this.averageHeight,
        this.skinColors,
        this.hairColors,
        this.eyeColors,
        this.averageLifespan,
        this.homeworld,
        this.language,
        this.people,
        this.films,
        this.created,
        this.edited,
        this.url});

  Species.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    classification = json['classification'];
    designation = json['designation'];
    averageHeight = json['average_height'];
    skinColors = json['skin_colors'];
    hairColors = json['hair_colors'];
    eyeColors = json['eye_colors'];
    averageLifespan = json['average_lifespan'];
    homeworld = json['homeworld'];
    language = json['language'];

    peopleUrls = json['people'].cast<String>();
    people = [];
    filmsUrls = json['films'].cast<String>();
    films = [];
    created = json['created'];
    edited = json['edited'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['classification'] = classification;
    data['designation'] = designation;
    data['average_height'] = averageHeight;
    data['skin_colors'] = skinColors;
    data['hair_colors'] = hairColors;
    data['eye_colors'] = eyeColors;
    data['average_lifespan'] = averageLifespan;
    data['homeworld'] = homeworld;
    data['language'] = language;
    data['people'] = people;
    data['films'] = films;
    data['created'] = created;
    data['edited'] = edited;
    data['url'] = url;
    return data;
  }
}