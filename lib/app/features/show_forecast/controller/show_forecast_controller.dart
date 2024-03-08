import 'package:flutter/foundation.dart';

import '../../../core/entities/city_show_entity.dart';
import '../../../core/entities/current_weather_entity.dart';
import '../../../core/entities/day_forecast_entity.dart';
import '../dto/get_current_weather_dto.dart';
import '../dto/get_forecast_dto.dart';
import '../repository/show_forecast_repository.dart';

class ShowForecastController extends ChangeNotifier {
  final ShowForecastRepository repository;

  ShowForecastController(this.repository);

  String? exception;
  bool isLoading = false;
  CurrentWeatherEntity? currentWeather;
  List<DayForecastEntity> forecast = [];

  Future<void> getCityCurrentWeather(CityShowEntity cityShowEntity) async {
    isLoading = true;
    exception = null;
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
        exception = null;
      },
      (failure) {
        currentWeather = null;
        exception = 'Couldn\'t get current weather. Code: ${failure.toString()}';
      },
    );
    notifyListeners();
  }

  Future<void> getCityForecast(CityShowEntity cityShowEntity) async {
    isLoading = true;
    exception = null;
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
        exception = null;
        forecast = success;
      },
      (failure) {
        forecast = [];
        exception = 'Couldn\'t get current weather. Code: ${failure.toString()}';
      },
    );
    notifyListeners();
  }
}
