// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:dio/dio.dart';
import 'package:uber_deep_link/util/api/endpoints.dart';
import 'package:uber_deep_link/util/api/keys.dart';

abstract class UberWebServices {
  Future<Response> getPlace(String placeName);
}

class UberWebServicesImp implements UberWebServices {
  final Dio dio;
  UberWebServicesImp({required this.dio});
  @override
  Future<Response> getPlace(String placeName) async {
    final response = await dio.get(
        '${Endpoints.baseUrl}?address=${Uri.encodeComponent(placeName)}&key=${ApiKeys.googleApiKey}');

    if (response.statusCode == 200) {
      if (response.data['results'].isNotEmpty) {
        return response;
      } else {
        throw Exception('No results found for the given place');
      }
    } else {
      throw Exception('Failed to load coordinates');
    }
  }
}
