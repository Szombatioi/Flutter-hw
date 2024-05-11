import 'data/character.dart';

class CharacterResponse {
  num? count;
  String? next;
  dynamic previous;
  List<Character>? results;

  CharacterResponse({
      this.count, 
      this.next, 
      this.previous, 
      this.results,});

  CharacterResponse.fromJson(dynamic json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = [];
      json['results'].forEach((v) {
        results?.add(Character.fromJson(v));
      });
    }
  }

  CharacterResponse copyWith({  num? count,
    String? next,
    dynamic previous,
    List<Character>? results,
  }) => CharacterResponse(  count: count ?? this.count,
    next: next ?? this.next,
    previous: previous ?? this.previous,
    results: results ?? this.results,
  );
}