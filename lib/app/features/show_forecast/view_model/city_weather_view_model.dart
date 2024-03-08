import 'package:equatable/equatable.dart';

import '../../../core/entities/city_show_entity.dart';
import '../../../core/entities/current_weather_entity.dart';

class CityWeatherViewModel extends Equatable {
  final CityShowEntity city;
  final CurrentWeatherEntity cityWeatherEntity;

  const CityWeatherViewModel({required this.city, required this.cityWeatherEntity});
  
  @override
  List<Object?> get props => [city, cityWeatherEntity];
}
