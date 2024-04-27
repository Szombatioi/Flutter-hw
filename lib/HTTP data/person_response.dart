import 'person.dart';

class PersonResponse {
  num? count;
  String? next;
  dynamic previous;
  List<Person>? results;

  PersonResponse({
      this.count, 
      this.next, 
      this.previous, 
      this.results,});

  PersonResponse.fromJson(dynamic json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = [];
      json['results'].forEach((v) {
        results?.add(Person.fromJson(v));
      });
    }
  }

  PersonResponse copyWith({  num? count,
    String? next,
    dynamic previous,
    List<Person>? results,
  }) => PersonResponse(  count: count ?? this.count,
    next: next ?? this.next,
    previous: previous ?? this.previous,
    results: results ?? this.results,
  );
}