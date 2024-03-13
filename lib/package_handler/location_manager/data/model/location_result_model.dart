import 'dart:convert';
import 'package:mobile_attendance/package_handler/location_manager/domain/entity/location_result.dart';

class LocationResultModel {
  const LocationResultModel({
    required this.latitude,
    required this.longitude,
  });

  final double latitude;
  final double longitude;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  factory LocationResultModel.fromMap(Map<String, dynamic> map) {
    return LocationResultModel(
      latitude: map['latitude'],
      longitude: map['longitude'],
    );
  }

  String toJson() => json.encode(toMap());

  factory LocationResultModel.fromJson(String source) =>
      LocationResultModel.fromMap(json.decode(source) as Map<String, dynamic>);

  LocationResult toEntity() {
    return LocationResult(latitude: latitude, longitude: longitude);
  }

  factory LocationResultModel.fromEntity(LocationResult entity) =>
      LocationResultModel(
        latitude: entity.latitude,
        longitude: entity.longitude,
      );
}
