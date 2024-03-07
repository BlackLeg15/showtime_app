import 'package:equatable/equatable.dart';

class CurrentWeatherEntity extends Equatable {
  final int id;
  final String icon;
  final String title;
  final String description;

  const CurrentWeatherEntity({
    required this.id,
    required this.icon,
    required this.title,
    required this.description,
  });
  
  @override
  List<Object?> get props => [id, icon, title, description];
}
