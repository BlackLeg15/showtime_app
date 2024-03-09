import '../../../core/entities/city_show_entity.dart';

/// Class that encapsulates the necessary parameters
/// to get a city's forecast weather
class GetForecastDto {
  /// Object that provides a city's name and country code
  final CityShowEntity _cityShowEntity;

  /// The app id necessary to request data from Open Weather's api
  final String appId;

  /// Creates an [GetCurrentWeatherDto] instance
  const GetForecastDto(this._cityShowEntity, this.appId);

  /// Turns the attributes into request params for
  /// the forecast weather request from Open Weather's api
  Map<String, dynamic> toParams() {
    return {
      'q': '${_cityShowEntity.name},${_cityShowEntity.countryCode}',
      'appid': appId,
    };
  }
}
