import '../../../core/entities/city_show_entity.dart';

class GetForecastDto {
  final CityShowEntity _cityShowEntity;
  final String appId;

  const GetForecastDto(this._cityShowEntity, this.appId);

  Map<String, dynamic> toParams() {
    return {
      'q': '${_cityShowEntity.name},${_cityShowEntity.countryCode}',
      'appid': appId,
    };
  }
}
