// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:mobile_attendance/package_handler/location_manager/domain/entity/location_result.dart';

class AttendanceData {
  AttendanceData({
    required this.location,
    this.distance,
  });

  final LocationResult location;
  final double? distance;

  AttendanceData copyWith({
    LocationResult? location,
    double? distance,
  }) {
    return AttendanceData(
      location: location ?? this.location,
      distance: distance ?? this.distance,
    );
  }
}
