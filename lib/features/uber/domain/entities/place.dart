import 'package:equatable/equatable.dart';

class Place extends Equatable {
  final String? name;
  final double lat;
  final double long;

  const Place({this.name, required this.lat, required this.long});

  @override
  List<Object?> get props => [name, lat, long];
}
