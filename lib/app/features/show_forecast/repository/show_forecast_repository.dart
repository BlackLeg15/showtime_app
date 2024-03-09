import 'package:result_dart/result_dart.dart';

import '../../../core/entities/current_weather_entity.dart';
import '../../../core/entities/day_weather_forecast_entity.dart';
import '../dto/get_current_weather_dto.dart';
import '../dto/get_forecast_dto.dart';

/// Class that declares the necessary functions
/// for the app to work with current weather and 
/// forecast weather.
abstract class ShowForecastRepository {
  /// Retrieves a city's current weather.
  /// If any exceptions happen, a Exception object is returned.
  /// It relies on the Result pattern.
  AsyncResult<CurrentWeatherEntity, Exception> getCityCurrentWeather(GetCurrentWeatherDto dto);

  /// Retrieves a city's 5-day weather forecast.
  /// If any exceptions happen, a Exception object is returned.
  /// It relies on the Result pattern.
  AsyncResult<List<DayWeatherForecastEntity>, Exception> getCityForecast(GetForecastDto dto);
}
