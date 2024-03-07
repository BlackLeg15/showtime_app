import 'package:result_dart/result_dart.dart';
import 'package:showtime_app/app/core/endpoints/endpoints.dart';
import 'package:showtime_app/app/core/entities/current_weather_entity.dart';
import 'package:showtime_app/app/core/http_client/base/http_client.dart';
import 'package:showtime_app/app/features/show_forecast/dto/get_current_weather_dto.dart';
import 'package:showtime_app/app/features/show_forecast/repository/show_forecast_mapper.dart';
import 'package:showtime_app/app/features/show_forecast/repository/show_forecast_repository.dart';

class ShowForecastRepositoryImp implements ShowForecastRepository {
  final HttpClient httpClient;

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
      (failure) => Exception(failure.message).toFailure(),
    );
  }
}
