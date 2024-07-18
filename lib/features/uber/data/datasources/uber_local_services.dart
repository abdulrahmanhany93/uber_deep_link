import 'dart:developer';

import 'package:uber_deep_link/features/uber/domain/entities/place.dart';
import 'package:url_launcher/url_launcher_string.dart';

abstract class UberLocalServices {
  Future<void> launchURL(Place place);
}

class UberLocalServicesImp implements UberLocalServices {
  @override
  Future<void> launchURL(Place place) async {
    try {
      final uberUrl =
          'uber://?action=setPickup&dropoff[latitude]=${place.lat}&dropoff[longitude]=${place.long}&dropoff[nickname]=${place.name}';
      if (await canLaunchUrlString(uberUrl)) {
        await launchUrlString(uberUrl);
      } else {
        throw 'Could not launch Uber app';
      }
    } catch (e) {
      log('Error launching URL: $e');
      rethrow;
    }
  }
}
