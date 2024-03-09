import 'package:equatable/equatable.dart';

import 'weather_forecast_entity.dart';

/// A representation of weather forecasts for a specific day
class DayWeatherForecastEntity extends Equatable {
  /// The list of weather forecasts for a specific day (i.e. [dateTime])
  final List<WeatherForecastEntity> weatherForecasts;

  /// The day for weather forecasts (i.e. [weatherForecasts])
  final String dateTime;

  const DayWeatherForecastEntity({
    required this.weatherForecasts,
    required this.dateTime,
  });

  @override
  List<Object?> get props => [weatherForecasts, dateTime];
}
