import 'package:flutter_hf/HTTP data/film.dart';

class FilmResponse {
  num? count;
  dynamic next;
  dynamic previous;
  List<Film>? results;

  FilmResponse({
      this.count, 
      this.next, 
      this.previous, 
      this.results,});

  FilmResponse.fromJson(dynamic json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = [];
      json['results'].forEach((v) {
        results?.add(Film.fromJson(v));
      });
    }
  }

  FilmResponse copyWith({  num? count,
    dynamic next,
    dynamic previous,
    List<Film>? results,
  }) => FilmResponse(  count: count ?? this.count,
    next: next ?? this.next,
    previous: previous ?? this.previous,
    results: results ?? this.results,
  );
}