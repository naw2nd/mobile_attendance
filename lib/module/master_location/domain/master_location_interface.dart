import 'package:mobile_attendance/package_handler/location_manager/domain/entity/location_result.dart';

abstract class MasterLocationInterface {
  Future setSavedLocation({required LocationResult location});
  Future<LocationResult?> getSavedLocation();
  Future clearSavedLocation();
}
