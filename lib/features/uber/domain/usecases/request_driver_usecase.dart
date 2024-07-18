import 'package:dartz/dartz.dart';
import 'package:uber_deep_link/features/uber/data/repositories/uber_repository.dart';
import 'package:uber_deep_link/features/uber/domain/entities/place.dart';
import 'package:uber_deep_link/util/error/failures.dart';
import 'package:uber_deep_link/util/usecases/usecase.dart';

class RequestDriverUsecase implements UseCase<void, Place> {
  final UberRepository repository;

  RequestDriverUsecase({required this.repository});

  @override
  Future<Either<Failure, void>> call(Place place) {
    return repository.launchURL(place);
  }
}
