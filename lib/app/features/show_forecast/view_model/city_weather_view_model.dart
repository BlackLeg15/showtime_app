import 'package:equatable/equatable.dart';

import '../../../core/entities/city_show_entity.dart';
import '../../../core/entities/current_weather_entity.dart';

/// This class encapsulates a city (i.e., [CityShowEntity]) 
/// and its (i.e., [CurrentWeatherEntity]) in order to
/// facilitate its presentation on a page.
class CityWeatherViewModel extends Equatable {
  final CityShowEntity city;
  final CurrentWeatherEntity cityWeatherEntity;

  const CityWeatherViewModel({required this.city, required this.cityWeatherEntity});
  
  @override
  List<Object?> get props => [city, cityWeatherEntity];
}
