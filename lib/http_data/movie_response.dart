import 'data/movie.dart';

class MovieResponse {
  num? count;
  dynamic next;
  dynamic previous;
  List<Movie>? results;

  MovieResponse({
      this.count, 
      this.next, 
      this.previous, 
      this.results,});

  MovieResponse.fromJson(dynamic json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = [];
      json['results'].forEach((v) {
        results?.add(Movie.fromJson(v));
      });
    }
  }

  MovieResponse copyWith({  num? count,
    dynamic next,
    dynamic previous,
    List<Movie>? results,
  }) => MovieResponse(  count: count ?? this.count,
    next: next ?? this.next,
    previous: previous ?? this.previous,
    results: results ?? this.results,
  );
}