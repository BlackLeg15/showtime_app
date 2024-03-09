import 'dart:convert';

import 'package:equatable/equatable.dart';

class CityShowEntity extends Equatable {
  /// e.g. São Paulo
  final String name;
  /// e.g. BR (for Brazil)
  final String countryCode;

  const CityShowEntity({required this.name, required this.countryCode});
  
  @override
  List<Object?> get props => [name, countryCode];

  /// Turns a [CityShowEntity] into a [Map] object
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'country_code': countryCode,
    };
  }

  /// Turns a [Map] into a [CityShowEntity] object
  factory CityShowEntity.fromMap(Map<String, dynamic> map) {
    return CityShowEntity(
      name: map['name'] as String,
      countryCode: map['country_code'] as String,
    );
  }

  /// Serializes a [CityShowEntity] object
  String toJson() => json.encode(toMap());

  /// Deserializes a [CityShowEntity] object
  factory CityShowEntity.fromJson(String source) => CityShowEntity.fromMap(json.decode(source) as Map<String, dynamic>);
}
