import 'package:flutter_hf/http_data/data/vehicle.dart';

class VehicleResponse {
  int? count;
  String? next;
  Null? previous;
  List<Vehicle>? results;

  VehicleResponse({this.count, this.next, this.previous, this.results});

  VehicleResponse.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = <Vehicle>[];
      json['results'].forEach((v) {
        results!.add(Vehicle.fromJson(v));
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