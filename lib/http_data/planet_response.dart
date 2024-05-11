import 'data/planet.dart';

class PlanetResponse {
  int? count;
  String? next;
  String? previous;
  List<Planet>? results;

  PlanetResponse({this.count, this.next, this.previous, this.results});

  PlanetResponse.fromJson(Map<String, dynamic> json) {
    count = json['count'] ?? 0;
    next = json['next'] ?? "";
    previous = json['previous'] ?? "";
    if (json['results'] != null) {
      results = <Planet>[];
      json['results'].forEach((v) {
        results!.add(Planet.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    data['next'] = next;
    data['previous'] = previous;
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}