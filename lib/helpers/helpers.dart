import 'package:dio/dio.dart'; // For handling HTTP requests

/// Extracts place name from a given URL.
/// Example: https://www.google.com/maps/place/San+Francisco/@37.7749,-122.4194,10z
String extractPlaceName(String url) {
  // Define regular expressions to match the place name in different URL formats.
  final regExp = RegExp(r'place/([^/]+)|q=([^&]+)');

  // Use the regular expression to find the first match in the URL.
  final match = regExp.firstMatch(url);

  // Extract the place name from the matched group, or default to 'Location' if not found.
  final encodedName = match?.group(1) ?? match?.group(2) ?? 'Location';

  // Decode the percent-encoded place name.
  final decodedName = Uri.decodeComponent(encodedName);

  // Return the decoded place name.
  return decodedName;
}

/// Extracts place name and coordinates from a given URL.
Map<String, dynamic>? extractCoordinates(String url) {
  // Define a regular expression to match the place name in the URL.
  final nameRegExp = RegExp(r'place/([^/]+)');

  // Define a regular expression to match the coordinates in the URL.
  final coordinatesRegExp = RegExp(r'@([0-9.]+),([0-9.]+)');

  // Use the regular expression to find the first match for the place name in the URL.
  final nameMatch = nameRegExp.firstMatch(url);

  // Use the regular expression to find the first match for the coordinates in the URL.
  final coordinatesMatch = coordinatesRegExp.firstMatch(url);

  // Extract the place name from the matched group, or default to 'Location' if not found.
  final encodedName = nameMatch?.group(1) ?? 'Location';

  // Decode the percent-encoded place name.
  final decodedName = Uri.decodeComponent(encodedName);

  // Extract the latitude from the matched group, or default to 'Unknown' if not found.
  final latitude = coordinatesMatch?.group(1);

  // Extract the longitude from the matched group, or default to 'Unknown' if not found.
  final longitude = coordinatesMatch?.group(2);

  // Return a map containing the decoded place name and coordinates.
  if (latitude != null && longitude != null) {
    return {
      'name': decodedName,
      'lat': double.parse(latitude),
      'long': double.parse(longitude),
    };
  }
  return null;
}

/// Extracts the full URL from a shortened URL by following HTTP redirects using dio package.
Future<String> extractFullUrl(String url) async {
  // Make an HTTP HEAD request to the given URL, following redirects.
  var response = await Dio().head(
    url,
    options: Options(
      followRedirects: false, // Disable automatic following of redirects.
      validateStatus: (status) {
        return status! <
            500; // Consider any status code less than 500 as valid.
      },
    ),
  );

  // Check if the response indicates a redirect (status code 301 or 302).
  if (response.statusCode == 302 || response.statusCode == 301) {
    // Return the value of the 'location' header, or a default message if not found.
    return response.headers.value('location') ?? 'No redirect location found';
  }

  // Return the original URL if no redirect was found.
  return url;
}
