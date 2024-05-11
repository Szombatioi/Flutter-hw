import 'package:flutter_hf/http_data/data/starship.dart';

class StarshipsResponse {
  int? count;
  String? next;
  Null? previous;
  List<Starship>? results;

  StarshipsResponse({this.count, this.next, this.previous, this.results});

  StarshipsResponse.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = <Starship>[];
      json['results'].forEach((v) {
        results!.add(Starship.fromJson(v));
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