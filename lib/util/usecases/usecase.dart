import 'package:dartz/dartz.dart';
import 'package:uber_deep_link/util/error/failures.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}
