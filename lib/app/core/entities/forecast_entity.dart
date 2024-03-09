import 'package:equatable/equatable.dart';

class ForecastEntity extends Equatable {
  final int id;
  final double tempMin;
  final double tempMax;

  const ForecastEntity({
    required this.id,
    required this.tempMin,
    required this.tempMax,
  });

  @override
  List<Object?> get props => [id, tempMax, tempMin];
}
