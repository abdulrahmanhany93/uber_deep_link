// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:uber_deep_link/features/uber/data/datasources/uber_local_services.dart';
import 'package:uber_deep_link/features/uber/data/datasources/uber_web_services.dart';
import 'package:uber_deep_link/features/uber/data/models/place_model.dart';
import 'package:uber_deep_link/features/uber/data/repositories/uber_repository.dart';
import 'package:uber_deep_link/features/uber/domain/entities/place.dart';
import 'package:uber_deep_link/util/error/failures.dart';

class UberRepositoryImp implements UberRepository {
  final UberWebServices webServices;
  final UberLocalServices localServices;

  UberRepositoryImp({
    required this.webServices,
    required this.localServices,
  });

  @override
  Future<Either<Failure, PlaceModel>> getPlace(String placeName) async {
    try {
      final result = await webServices.getPlace(placeName);
      if (result.statusCode == 200) {
        final location = result.data!['results'][0]['geometry']['location'];
        final placeName = result.data!['results'][0]['formatted_address'];
        return Right(PlaceModel.fromMap({
          'name': placeName,
          'lat': location['lat'],
          'lng': location['lng'],
        }));
      } else {
        return Left(NotFoundFailure(result.statusMessage!));
      }
    } catch (e) {
      return Left(NotFoundFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> launchURL(Place place) async {
    try {
      await localServices.launchURL(place);
      return const Right(null);
    } catch (e) {
      return Left(NotFoundFailure(e.toString()));
    }
  }
}
