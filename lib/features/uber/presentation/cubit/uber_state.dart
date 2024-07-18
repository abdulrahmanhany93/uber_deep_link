part of 'uber_cubit.dart';

abstract class UberState extends Equatable {
  const UberState();

  @override
  List<Object> get props => [];
}

class UberInitial extends UberState {}
class GettingPlaceData extends UberState {}

class GotPlaceData extends UberState {
  final Place place;
  const GotPlaceData(this.place);
}

class UberError extends UberState {
  final String message;
  const UberError(this.message);
}
class RequestingDriver extends UberState {}

class RequestedDriver extends UberState {}
