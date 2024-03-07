import 'package:result_dart/result_dart.dart';
import 'package:showtime_app/app/core/entities/city_show_entity.dart';

class AllShowsMapper {
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
