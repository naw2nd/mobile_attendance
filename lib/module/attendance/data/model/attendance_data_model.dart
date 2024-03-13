import 'dart:convert';

import 'package:mobile_attendance/module/attendance/domain/entity/attendance_data.dart';
import 'package:mobile_attendance/package_handler/location_manager/data/model/location_result_model.dart';

class AttendanceDataModel {
  AttendanceDataModel({
    required this.location,
    this.distance,
  });

  final LocationResultModel location;
  final double? distance;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'location': location.toMap(),
      'distance': distance,
    };
  }

  factory AttendanceDataModel.fromMap(Map<String, dynamic> map) {
    return AttendanceDataModel(
      location:
          LocationResultModel.fromMap(map['location'] as Map<String, dynamic>),
      distance: map['distance'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AttendanceDataModel.fromJson(String source) =>
      AttendanceDataModel.fromMap(json.decode(source) as Map<String, dynamic>);

  AttendanceData toEntity() {
    return AttendanceData(location: location.toEntity(), distance: distance);
  }

  factory AttendanceDataModel.fromEntity(AttendanceData entity) =>
      AttendanceDataModel(
        location: LocationResultModel.fromEntity(entity.location),
        distance: entity.distance,
      );

  static List<AttendanceData> toEntities(List<AttendanceDataModel> model) {
    return model.map((e) => e.toEntity()).toList();
  }

  static List<AttendanceDataModel> fromEntities(List<AttendanceData> model) {
    return model.map((e) => AttendanceDataModel.fromEntity(e)).toList();
  }
}
