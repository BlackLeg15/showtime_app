import 'package:intl/intl.dart';
import 'package:result_dart/result_dart.dart';

import '../../../core/entities/current_weather_entity.dart';
import '../../../core/entities/day_forecast_entity.dart';
import '../../../core/entities/forecast_entity.dart';

class ShowForecastMapper {
  static Result<List<DayForecastEntity>, Exception> fromForecastResponse(dynamic response) {
    if (response is! Map || response.isEmpty) {
      return Exception('forecast-invalid-response').toFailure();
    }

    final list = response['list'];
    if (list is! List || list.isEmpty) {
      return Exception('forecast-list-invalid-response').toFailure();
    }
    late List<DayForecastEntity> dayForecastEntity;
    Map<String, List<ForecastEntity>> map = {};
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
      final entity = ForecastEntity(
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
    dayForecastEntity = map.entries.map((e) => DayForecastEntity(forecast: e.value, dateTime: e.key)).toList();
    return dayForecastEntity.toSuccess();
  }

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
