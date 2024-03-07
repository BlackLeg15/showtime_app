import 'package:result_dart/result_dart.dart';

import '../../../core/entities/current_weather_entity.dart';

class ShowForecastMapper {
  static Result<CurrentWeatherEntity, Exception> fromCurrentWeatherResponse(dynamic response) {
    if (response is! Map || response.isEmpty) {
      return Exception('current-weather-invalid-response').toFailure();
    }

    final weather = response['weather'];
    if (weather is! List || weather.isEmpty) {
      return Exception('current-weather-invalid-weather').toFailure();
    }

    final weatherMap = weather.first;
    if (weatherMap is! Map || weatherMap.isEmpty) {
      return Exception('current-weather-invalid-weather-object').toFailure();
    }

    final id = weatherMap['id'];
    if (id is! int) {
      return Exception('current-weather-invalid-id').toFailure();
    }

    final description = weatherMap['description'];
    if (description is! String) {
      return Exception('current-weather-invalid-description').toFailure();
    }

    final main = weatherMap['main'];
    if (main is! String) {
      return Exception('current-weather-invalid-main').toFailure();
    }

    final icon = weatherMap['icon'];
    if (icon is! String) {
      return Exception('current-weather-invalid-icon').toFailure();
    }

    return CurrentWeatherEntity(
      id: id,
      icon: icon,
      title: main,
      description: description,
    ).toSuccess();
  }
}
