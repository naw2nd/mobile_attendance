import 'package:mobile_attendance/package_handler/location_manager/domain/entity/location_result.dart';

abstract class LocationManager {
  Future<LocationResult?> getCurrentLocation({bool isAllowMocked});
  double getDistanceBetween(LocationResult location1, LocationResult location2);
}
