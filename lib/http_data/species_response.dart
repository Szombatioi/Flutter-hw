import 'package:flutter_hf/http_data/data/species.dart';

class SpeciesResponse {
  int? count;
  String? next;
  String? previous;
  List<Species>? results;

  SpeciesResponse({this.count, this.next, this.previous, this.results});

  SpeciesResponse.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = <Species>[];
      json['results'].forEach((v) {
        results!.add(Species.fromJson(v));
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