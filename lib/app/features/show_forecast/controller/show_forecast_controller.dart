import 'package:flutter/foundation.dart';

import '../../../core/entities/city_show_entity.dart';
import '../../../core/entities/current_weather_entity.dart';
import '../../../core/entities/day_weather_forecast_entity.dart';
import '../dto/get_current_weather_dto.dart';
import '../dto/get_forecast_dto.dart';
import '../repository/show_forecast_repository.dart';

/// Given a city, this class controls states involving gettings its current and forecasted weather,
/// as well as changing-state functions.
/// It relies on [ShowForecastRepository] to get its data.
class ShowForecastController extends ChangeNotifier {
  final ShowForecastRepository repository;

  /// Creates an [ShowForecastController] instance
  ShowForecastController(this.repository);

  String? currentWeatherException;
  String? forecastException;
  bool isLoading = false;
  CurrentWeatherEntity? currentWeather;
  List<DayWeatherForecastEntity> forecast = [];

  Future<void> getCityCurrentWeather(CityShowEntity cityShowEntity) async {
    isLoading = true;
    currentWeatherException = null;
    notifyListeners();

    final result = await repository.getCityCurrentWeather(
      GetCurrentWeatherDto(
        cityShowEntity,
        const String.fromEnvironment('appid'),
      ),
    );

    isLoading = false;
    result.fold(
      (success) {
        currentWeather = success;
        currentWeatherException = null;
      },
      (failure) {
        currentWeather = null;
        currentWeatherException = 'Couldn\'t get current weather. ${failure.toString()}';
      },
    );
    notifyListeners();
  }

  Future<void> getCityForecast(CityShowEntity cityShowEntity) async {
    isLoading = true;
    forecastException = null;
    notifyListeners();

    final result = await repository.getCityForecast(
      GetForecastDto(
        cityShowEntity,
        const String.fromEnvironment('appid'),
      ),
    );

    isLoading = false;
    result.fold(
      (success) {
        forecastException = null;
        forecast = success;
      },
      (failure) {
        forecast = [];
        forecastException = 'Couldn\'t get city\'s forecast. ${failure.toString()}';
      },
    );
    notifyListeners();
  }
}
