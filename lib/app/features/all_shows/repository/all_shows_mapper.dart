import 'package:result_dart/result_dart.dart';

import '../../../core/entities/city_show_entity.dart';

/// Class that provides functions to turn responses
/// from requests involving the list of cities into suitable Dart objects.
/// It relies on the Result pattern.
class AllShowsMapper {
  /// Turns the reponse from the request list of cities request into a suitable Dart object.
  /// If any exceptions happen, it returns an Exception object.
  /// It relies on the Result pattern.
  static Result<List<CityShowEntity>, Exception> fromCityListResponse(dynamic response) {
    if (response is! List) {
      return Exception('city-list-invalid-response').toFailure();
    }
    final cityList = <CityShowEntity>[];
    for (var i = 0; i < response.length; i++) {
      final cityMap = response[i];
      if (cityMap is! Map) {
        return Exception('city-object-invalid-response').toFailure();
      }

      final name = cityMap['name'];
      if (name is! String || name.isEmpty) {
        return Exception('city-name-invalid-response').toFailure();
      }

      final countryCode = cityMap['country_code'];
      if (countryCode is! String || countryCode.isEmpty) {
        return Exception('city-countryCode-invalid-response').toFailure();
      }

      cityList.add(
        CityShowEntity(
          name: name,
          countryCode: countryCode,
        ),
      );
    }
    return cityList.toSuccess();
  }
}
