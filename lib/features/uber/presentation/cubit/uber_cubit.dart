// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:uber_deep_link/features/uber/data/models/place_model.dart';
import 'package:uber_deep_link/features/uber/domain/entities/place.dart';
import 'package:uber_deep_link/features/uber/domain/usecases/get_place_usecase.dart';
import 'package:uber_deep_link/features/uber/domain/usecases/request_driver_usecase.dart';
import 'package:uber_deep_link/helpers/helpers.dart';

part 'uber_state.dart';

class UberCubit extends Cubit<UberState> {
  UberCubit(
    this._getPlaceUsecase,
    this._requestDriverUsecase,
  ) : super(UberInitial());
  final GetPlaceUsecase _getPlaceUsecase;
  final RequestDriverUsecase _requestDriverUsecase;
  String currentPlaceName = '';
  Place? place;
  Future<void> _getPlaceName(String shortUrl) async {
    try {
      final fullUrl = await extractFullUrl(shortUrl);
      log('Full URL: $fullUrl'); // Log the full URL for debugging
      final coordinates = extractCoordinates(fullUrl);
      if (coordinates != null) {
        place = PlaceModel.fromMap(coordinates);
      }

      if (place == null) {
        currentPlaceName = extractPlaceName(fullUrl);
      }
    } catch (e) {
      emit(UberError(e.toString()));
    }
  }

  void getPlace(String shortUrl) async {
    emit(GettingPlaceData());
    await _getPlaceName(shortUrl);
    if (place != null) {
      emit(GotPlaceData(place!));
    } else {
      final result = await _getPlaceUsecase(currentPlaceName);
      result.fold((error) => emit(UberError(error.message)), (place) {
        emit(GotPlaceData(place));
      });
    }
  }

  void requestDriver(Place place) async {
    emit(RequestingDriver());
    final result = await _requestDriverUsecase(place);
    result.fold((error) => emit(UberError(error.message)), (place) {
      emit(RequestedDriver());
    });
  }
}
