import 'dart:developer';

import 'package:geolocator/geolocator.dart';
import 'package:mobile_attendance/package_handler/location_manager/data/model/location_result_model.dart';
import 'package:mobile_attendance/package_handler/location_manager/domain/entity/location_result.dart';
import 'package:mobile_attendance/package_handler/location_manager/domain/location_manager.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationManagerImpl implements LocationManager {
  final _locationErrorNameLog = 'Location Manager Error';

  @override
  Future<LocationResult?> getCurrentLocation(
      {bool isAllowMocked = false}) async {
    try {
      await Permission.location.request();
      final position = await Geolocator.getCurrentPosition();

      if (!position.isMocked || isAllowMocked) {
        final model = LocationResultModel(
          latitude: position.latitude,
          longitude: position.longitude,
        );
        final result = model.toEntity();

        return result;
      }
    } catch (e) {
      log(e.toString(), name: _locationErrorNameLog);
      throw Exception('Terjadi kesalahan saat mengambil lokasi saat ini');
    }
    return null;
  }

  @override
  double getDistanceBetween(
      LocationResult startLocation, LocationResult endLocation) {
    final distance = Geolocator.distanceBetween(startLocation.latitude,
        startLocation.longitude, endLocation.latitude, endLocation.longitude);
    return distance;
  }
}
