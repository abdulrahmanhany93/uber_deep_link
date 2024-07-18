import 'package:dartz/dartz.dart';
import 'package:uber_deep_link/features/uber/data/repositories/uber_repository.dart';
import 'package:uber_deep_link/features/uber/domain/entities/place.dart';
import 'package:uber_deep_link/util/error/failures.dart';
import 'package:uber_deep_link/util/usecases/usecase.dart';

class GetPlaceUsecase implements UseCase<Place, String> {
  final UberRepository repository;

  GetPlaceUsecase({required this.repository});

  @override
  Future<Either<Failure, Place>> call(String params) {
    return repository.getPlace(params);
  }
}
