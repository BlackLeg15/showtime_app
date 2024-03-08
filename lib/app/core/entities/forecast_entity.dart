import 'package:equatable/equatable.dart';

class ForecastEntity extends Equatable {
  final double tempMin;
  final double tempMax;

  const ForecastEntity({
    required this.tempMin,
    required this.tempMax,
  });
  
  @override
  List<Object?> get props => [tempMax, tempMin];
}
