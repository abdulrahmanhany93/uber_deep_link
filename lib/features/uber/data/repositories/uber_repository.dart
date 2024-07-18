import 'package:dartz/dartz.dart';
import 'package:uber_deep_link/features/uber/data/models/place_model.dart';
import 'package:uber_deep_link/features/uber/domain/entities/place.dart';
import 'package:uber_deep_link/util/error/failures.dart';

abstract class UberRepository {
  Future<Either<Failure, PlaceModel>> getPlace(String placeName);

  Future<Either<Failure, void>> launchURL(Place place);
}
