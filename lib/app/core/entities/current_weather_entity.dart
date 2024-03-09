import 'package:equatable/equatable.dart';

/// A representation of the current weather
class CurrentWeatherEntity extends Equatable {
  /// Unique id (e.g. 501)
  final int id;
  /// Current weather's main description (e.g. Rain)
  final String title;
  /// Current weather's description (e.g. moderate rain)
  final String description;

  const CurrentWeatherEntity({
    required this.id,
    required this.title,
    required this.description,
  });
  
  @override
  List<Object?> get props => [id, title, description];
}
