// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class CityShowEntity extends Equatable {
  final String name;
  final String countryCode;

  const CityShowEntity({required this.name, required this.countryCode});
  
  @override
  List<Object?> get props => [name, countryCode];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'countryCode': countryCode,
    };
  }

  factory CityShowEntity.fromMap(Map<String, dynamic> map) {
    return CityShowEntity(
      name: map['name'] as String,
      countryCode: map['countryCode'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CityShowEntity.fromJson(String source) => CityShowEntity.fromMap(json.decode(source) as Map<String, dynamic>);
}
