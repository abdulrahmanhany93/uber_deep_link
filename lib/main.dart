import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:uber_deep_link/app.dart';
import 'package:uber_deep_link/util/bloc/bloc_observer.dart';
import 'package:uber_deep_link/util/service/service_locator.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  setupServiceLocator();
  runApp(const MyApp());
}
