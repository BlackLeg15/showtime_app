import 'package:intl/intl.dart';
import 'package:result_dart/result_dart.dart';

import '../../../core/entities/current_weather_entity.dart';
import '../../../core/entities/day_weather_forecast_entity.dart';
import '../../../core/entities/weather_forecast_entity.dart';

/// Class that provides functions to turn responses from requests 
/// to Open Weather API into suitable Dart objects.
/// It relies on the Result pattern.
class ShowForecastMapper {
  /// Turns the response from the forecast request into a suitable Dart object.
  /// If any exceptions happen, it returns an Exception object.
  /// It relies on the Result pattern.
  static Result<List<DayWeatherForecastEntity>, Exception> fromForecastResponse(dynamic response) {
    if (response is! Map || response.isEmpty) {
      return Exception('forecast-invalid-response').toFailure();
    }

    final list = response['list'];
    if (list is! List || list.isEmpty) {
      return Exception('forecast-list-invalid-response').toFailure();
    }
    late List<DayWeatherForecastEntity> dayForecastEntity;
    Map<String, List<WeatherForecastEntity>> map = {};
    final dateFormatter = DateFormat.yMMMMd('pt_BR');
    for (var i = 0; i < list.length; i++) {
      final forecast = list[i];
      final date = forecast['dt_txt'];
      final mainObject = forecast['main'];
      if (mainObject is! Map) {
        return Exception('forecast-main-invalid-response').toFailure();
      }
      final tempMin = mainObject['temp_min'];
      if (tempMin is! num) {
        return Exception('forecast-temp-min-invalid-response').toFailure();
      }
      final tempMax = mainObject['temp_max'];
      if (tempMax is! num) {
        return Exception('forecast-temp-max-invalid-response').toFailure();
      }
      final weatherList = forecast['weather'];
      if (weatherList is! List || weatherList.isEmpty) {
        return Exception('forecast-weather-invalid-response').toFailure();
      }
      final weatherObject = weatherList.first;
      if (weatherObject is! Map) {
        return Exception('forecast-weather-object-invalid-response').toFailure();
      }
      final id = weatherObject['id'];
      if (id is! int) {
        return Exception('forecast-weather-id-invalid-response').toFailure();
      }
      final entity = WeatherForecastEntity(
        id: id,
        tempMin: tempMin * 1.0,
        tempMax: tempMax * 1.0,
      );
      late final String formattedDate;
      try {
        formattedDate = dateFormatter.format(DateTime.parse(date));
      } catch (e) {
        return Exception('forecast-date-invalid-response').toFailure();
      }
      if (map.containsKey(formattedDate)) {
        map[formattedDate]!.add(entity);
      } else {
        map[formattedDate] = [entity];
      }
    }
    dayForecastEntity = map.entries.map((e) => DayWeatherForecastEntity(weatherForecasts: e.value, dateTime: e.key)).toList();
    return dayForecastEntity.toSuccess();
  }

  /// Turns response from the current weather request
  /// into a suitable Dart object.
  /// If any exceptions happen,
  /// it returns an Exception object.
  /// It relies on the Result pattern.
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

    return CurrentWeatherEntity(
      id: id,
      title: main,
      description: description,
    ).toSuccess();
  }
}
