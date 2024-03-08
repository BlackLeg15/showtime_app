import 'package:result_dart/result_dart.dart';

import '../../../core/entities/current_weather_entity.dart';
import '../../../core/entities/day_forecast_entity.dart';
import '../dto/get_current_weather_dto.dart';
import '../dto/get_forecast_dto.dart';

abstract class ShowForecastRepository {
  AsyncResult<CurrentWeatherEntity, Exception> getCityCurrentWeather(GetCurrentWeatherDto dto);
  AsyncResult<List<DayForecastEntity>, Exception> getCityForecast(GetForecastDto dto);
}
