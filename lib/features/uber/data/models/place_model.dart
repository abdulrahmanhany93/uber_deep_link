// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:uber_deep_link/features/uber/domain/entities/place.dart';

class PlaceModel extends Place {
  const PlaceModel({
    required super.name,
    required super.lat,
    required super.long,
  });

  factory PlaceModel.fromMap(Map<String, dynamic> map) {
    return PlaceModel(
      name: map['name'],
      lat: map['lat'],
      long: map['long'] ?? map['lng'],
    );
  }
}
