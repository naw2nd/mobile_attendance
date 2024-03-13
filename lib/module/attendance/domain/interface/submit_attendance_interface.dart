import 'package:mobile_attendance/module/attendance/domain/entity/attendance_data.dart';
import 'package:mobile_attendance/package_handler/location_manager/domain/entity/location_result.dart';

abstract class SubmitAttendanceInterface {
  Future storeAttendance(
      {required AttendanceData data,
      required LocationResult location,
      double maxAttendanceDistance});
  Future<List<AttendanceData>> fetchSavedAttendances();
  Future clearAttendance();
}
