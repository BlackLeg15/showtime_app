import 'package:result_dart/result_dart.dart';
import 'package:showtime_app/app/core/entities/current_weather_entity.dart';
import 'package:showtime_app/app/features/show_forecast/dto/get_current_weather_dto.dart';

abstract class ShowForecastRepository {
  AsyncResult<CurrentWeatherEntity, Exception> getCityCurrentWeather(GetCurrentWeatherDto dto);
}
