import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_attendance/module/master_location/data/master_location_repository.dart';
import 'package:mobile_attendance/module/master_location/domain/master_location_interface.dart';
import 'package:mobile_attendance/package_handler/location_manager/domain/entity/location_result.dart';
import 'package:mobile_attendance/package_handler/location_manager/domain/location_manager.dart';

class MasterLocationController extends GetxController {
  final MasterLocationInterface masterLocationInterface =
      MasterLocationRepository(localStorage: Get.find());
  final LocationManager locationManager = Get.find();

  final savedLocation = const LocationResult(latitude: 0, longitude: 0).obs;
  final initalLocation = const LocationResult(latitude: 0, longitude: 0).obs;

  @override
  void onInit() {
    super.onInit();
    setInitalLocation();
    getSavedLocation();
  }

  Future<void> getSavedLocation() async {
    try {
      savedLocation.value = await masterLocationInterface.getSavedLocation() ??
          const LocationResult(latitude: 0, longitude: 0);
    } on Exception catch (e) {
      Get.dialog(AlertDialog(
        content: Text(e.toString()),
      ));
    }
  }

  Future<void> setSavedLocation({required LocationResult location}) async {
    try {
      await masterLocationInterface.setSavedLocation(location: location);
      getSavedLocation();
    } on Exception catch (e) {
      Get.dialog(AlertDialog(
        content: Text(e.toString()),
      ));
    }
  }

  Future<void> setInitalLocation() async {
    try {
      final currentLocation =
          await locationManager.getCurrentLocation(isAllowMocked: true);
      if (currentLocation != null) {
        initalLocation(currentLocation);
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> clearSavedLocation() async {
    try {
      await masterLocationInterface.clearSavedLocation();
      await getSavedLocation();
    } catch (e) {
      Get.dialog(AlertDialog(
        content: Text(e.toString()),
      ));
    }
  }
}
