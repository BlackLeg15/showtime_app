import 'package:equatable/equatable.dart';

/// A representation of a weather forecast
class WeatherForecastEntity extends Equatable {
  /// Unique identification (e.g. 501)
  final int id;
  /// Lowest forecast temperature (e.g. 295.0)
  final double tempMin;
  /// Maximum forecast temperature (e.g. 302.0)
  final double tempMax;

  const WeatherForecastEntity({
    required this.id,
    required this.tempMin,
    required this.tempMax,
  });

  @override
  List<Object?> get props => [id, tempMax, tempMin];
}
