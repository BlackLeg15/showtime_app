import '../../../core/entities/city_show_entity.dart';

class GetCurrentWeatherDto {
  final CityShowEntity _cityShowEntity;
  final String appId;

  const GetCurrentWeatherDto(this._cityShowEntity, this.appId);

  Map<String, String> toParams() {
    return {
      'q': '${_cityShowEntity.name},${_cityShowEntity.countryCode}',
      'appid': appId,
    };
  }
}
