import 'dart:convert';

import 'package:mobile_attendance/shared/constant.dart';
import 'package:mobile_attendance/module/attendance/data/model/attendance_data_model.dart';
import 'package:mobile_attendance/module/attendance/domain/entity/attendance_data.dart';
import 'package:mobile_attendance/module/attendance/domain/interface/submit_attendance_interface.dart';
import 'package:mobile_attendance/package_handler/local_storage/domain/local_storage.dart';
import 'package:mobile_attendance/package_handler/location_manager/domain/entity/location_result.dart';
import 'package:mobile_attendance/package_handler/location_manager/domain/location_manager.dart';

class SubmitAttendanceRepository implements SubmitAttendanceInterface {
  final LocalStorage localStorage;
  final LocationManager locationManager;

  final _savedAttendancesKey = 'savedAttendances';

  SubmitAttendanceRepository({
    required this.localStorage,
    required this.locationManager,
  });

  @override
  Future<List<AttendanceData>> fetchSavedAttendances() async {
    List<AttendanceData> result = [];

    final rawData = await localStorage.fetch(key: _savedAttendancesKey);
    if (rawData != null) {
      final List jsonList = jsonDecode(rawData);
      final models =
          jsonList.map((json) => AttendanceDataModel.fromMap(json)).toList();
      result = AttendanceDataModel.toEntities(models);
    }
    return result;
  }

  @override
  Future storeAttendance({
    required AttendanceData data,
    required LocationResult location,
    double maxAttendanceDistance = Constant.defaultMaxLocationRadius,
  }) async {
    final currentLocation = await locationManager.getCurrentLocation();
    if (currentLocation != null) {
      final distance = locationManager.getDistanceBetween(
          currentLocation,
          LocationResult(
            latitude: location.latitude,
            longitude: location.longitude,
          ));

      if (distance <= maxAttendanceDistance) {
        final attendanceData = data.copyWith(distance: distance);

        List<AttendanceData> savedAttendances = await fetchSavedAttendances();
        savedAttendances.add(attendanceData);

        final models = AttendanceDataModel.fromEntities(savedAttendances);
        final json = models.map((model) => model.toMap()).toList();

        await localStorage.store(
            key: _savedAttendancesKey, value: jsonEncode(json));
      } else {
        throw Exception(
            'Jarak lokasi anda = ${distance.toStringAsFixed(2)} m, lebih dari jarak maksimal yang ditentukan ($maxAttendanceDistance m)');
      }
    }
  }

  @override
  Future clearAttendance() async {
    await localStorage.remove(key: _savedAttendancesKey);
  }
}
