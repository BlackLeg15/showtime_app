import 'package:equatable/equatable.dart';

import 'forecast_entity.dart';

class DayForecastEntity extends Equatable {
  final List<ForecastEntity> forecast;
  final String dateTime;

  const DayForecastEntity({
    required this.forecast,
    required this.dateTime,
  });
  
  @override
  List<Object?> get props => [forecast, dateTime];
}
