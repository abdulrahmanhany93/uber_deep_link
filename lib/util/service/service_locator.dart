import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:uber_deep_link/features/uber/data/datasources/uber_local_services.dart';
import 'package:uber_deep_link/features/uber/data/datasources/uber_web_services.dart';
import 'package:uber_deep_link/features/uber/data/repositories/uber_repository.dart';
import 'package:uber_deep_link/features/uber/domain/repositories/uber_imp_repository.dart';
import 'package:uber_deep_link/features/uber/domain/usecases/get_place_usecase.dart';
import 'package:uber_deep_link/features/uber/domain/usecases/request_driver_usecase.dart';
import 'package:uber_deep_link/features/uber/presentation/cubit/uber_cubit.dart';

final sl = GetIt.instance;

Future<void> setupServiceLocator() async {
//! ------------------------------------------------------------
//!                       Cubits
//! ------------------------------------------------------------
  sl.registerLazySingleton<UberCubit>(() => UberCubit(sl(), sl()));

//! ------------------------------------------------------------
//!                       Cubits
//! ------------------------------------------------------------

//! ------------------------------------------------------------
//!                       Data Services
//! ------------------------------------------------------------

//* ------------------------------------------------------------

  sl.registerLazySingleton<UberWebServices>(
      () => UberWebServicesImp(dio: sl()));
  sl.registerLazySingleton<UberLocalServices>(() => UberLocalServicesImp());

//* ------------------------------------------------------------

//! ------------------------------------------------------------
//!                       Data Services
//! ------------------------------------------------------------
//****************************************************************
//! ------------------------------------------------------------
//!                       Repositories
//! ------------------------------------------------------------

//* ------------------------------------------------------------
  sl.registerLazySingleton<UberRepository>(
      () => UberRepositoryImp(localServices: sl(), webServices: sl()));
//* ------------------------------------------------------------
//! ------------------------------------------------------------
//!                       Repositories
//! ------------------------------------------------------------
//****************************************************************
//! ------------------------------------------------------------
//!                       UseCases
//! ------------------------------------------------------------
//* ------------------------------------------------------------
  sl.registerLazySingleton<GetPlaceUsecase>(
      () => GetPlaceUsecase(repository: sl()));
  sl.registerLazySingleton<RequestDriverUsecase>(
      () => RequestDriverUsecase(repository: sl()));

//* ------------------------------------------------------------
//! ------------------------------------------------------------
//!                       UseCases
//! ------------------------------------------------------------
//****************************************************************
//! ------------------------------------------------------------
//!                       Extras
//! ------------------------------------------------------------

  sl.registerLazySingleton<Dio>(() => Dio());
}
