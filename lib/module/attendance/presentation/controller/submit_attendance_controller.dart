import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_attendance/module/attendance/data/repository/submit_attendance_repository.dart';
import 'package:mobile_attendance/module/attendance/domain/entity/attendance_data.dart';
import 'package:mobile_attendance/module/attendance/domain/interface/submit_attendance_interface.dart';
import 'package:mobile_attendance/module/master_location/data/master_location_repository.dart';
import 'package:mobile_attendance/module/master_location/domain/master_location_interface.dart';
import 'package:mobile_attendance/package_handler/location_manager/domain/entity/location_result.dart';
import 'package:mobile_attendance/package_handler/location_manager/domain/location_manager.dart';

class SubmitAttendanceController extends GetxController {
  final SubmitAttendanceInterface submitAttendanceInterface =
      SubmitAttendanceRepository(
    localStorage: Get.find(),
    locationManager: Get.find(),
  );
  final MasterLocationInterface masterLocationInterface =
      MasterLocationRepository(localStorage: Get.find());

  final LocationManager locationManagerInterface = Get.find();

  final savedAttendances = <AttendanceData>[].obs;

  @override
  void onInit() async {
    await getAllSavedAttendaces();
    super.onInit();
  }

  Future getAllSavedAttendaces() async {
    try {
      final attendances =
          await submitAttendanceInterface.fetchSavedAttendances();
      savedAttendances.assignAll(attendances);
    } on Exception catch (e) {
      Get.dialog(AlertDialog(
        content: Text(e.toString()),
      ));
    }
  }

  Future saveAttendance() async {
    try {
      final attendanceLocation = await locationManagerInterface
          .getCurrentLocation(isAllowMocked: true);

      final savedLocation = await getMasterLocation();
      if (attendanceLocation != null && savedLocation != null) {
        final attendanceData = AttendanceData(location: attendanceLocation);
        await submitAttendanceInterface.storeAttendance(
            data: attendanceData, location: savedLocation);
      }

      await getAllSavedAttendaces();
    } catch (e) {
      Get.dialog(AlertDialog(
        content: Text(e.toString()),
      ));
    }
  }

  Future<LocationResult?> getMasterLocation() async {
    LocationResult? result;
    try {
      result = await masterLocationInterface.getSavedLocation();
    } catch (e) {
      Get.dialog(AlertDialog(
        content: Text(e.toString()),
      ));
    }

    return result;
  }

  Future<void> clearSavedAttendances() async {
    try {
      await submitAttendanceInterface.clearAttendance();
      await getAllSavedAttendaces();
    } catch (e) {
      Get.dialog(AlertDialog(
        content: Text(e.toString()),
      ));
    }
  }
}
