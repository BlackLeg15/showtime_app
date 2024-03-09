import 'package:result_dart/result_dart.dart';

import '../../../core/endpoints/endpoints.dart';
import '../../../core/entities/current_weather_entity.dart';
import '../../../core/entities/day_weather_forecast_entity.dart';
import '../../../core/http_client/base/http_client.dart';
import '../dto/get_current_weather_dto.dart';
import '../dto/get_forecast_dto.dart';
import 'show_forecast_mapper.dart';
import 'show_forecast_repository.dart';

/// Class that implements the necessary functions
/// for the app to work with current weather and 
/// forecast weather.
/// It relies on a [HttpClient] instance to execute http requests.
class ShowForecastRepositoryImp implements ShowForecastRepository {
  final HttpClient httpClient;

  ///Creates an [ShowForecastRepositoryImp] instance.
  ShowForecastRepositoryImp(this.httpClient);

  @override
  AsyncResult<CurrentWeatherEntity, Exception> getCityCurrentWeather(GetCurrentWeatherDto dto) async {
    final response = await httpClient.get(
      Endpoints.current,
      queryParameters: dto.toParams(),
    );

    return response.fold(
      (success) {
        final result = ShowForecastMapper.fromCurrentWeatherResponse(success.data);
        return result;
      },
      (failure) => Exception(failure.statusCode).toFailure(),
    );
  }

  @override
  AsyncResult<List<DayWeatherForecastEntity>, Exception> getCityForecast(GetForecastDto dto) async {
    final response = await httpClient.get(
      Endpoints.forecast,
      queryParameters: dto.toParams(),
    );

    return response.fold(
      (success) {
        final result = ShowForecastMapper.fromForecastResponse(success.data);
        return result;
      },
      (failure) => Exception(failure.statusCode).toFailure(),
    );
  }
}
