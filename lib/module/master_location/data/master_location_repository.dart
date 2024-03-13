import 'package:mobile_attendance/module/master_location/domain/master_location_interface.dart';
import 'package:mobile_attendance/package_handler/local_storage/domain/local_storage.dart';
import 'package:mobile_attendance/package_handler/location_manager/data/model/location_result_model.dart';
import 'package:mobile_attendance/package_handler/location_manager/domain/entity/location_result.dart';

class MasterLocationRepository implements MasterLocationInterface {
  MasterLocationRepository({required this.localStorage});

  final LocalStorage localStorage;
  final _savedLocationKey = 'savedLocation';

  @override
  Future<LocationResult?> getSavedLocation() async {
    LocationResult? result;
    final json = await localStorage.fetch(key: _savedLocationKey);
    if (json != null) {
      final model = LocationResultModel.fromJson(json);
      result = model.toEntity();
    }
    return result;
  }

  @override
  Future setSavedLocation({required LocationResult location}) async {
    final model = LocationResultModel.fromEntity(location);
    final json = model.toJson();

    await localStorage.store(key: _savedLocationKey, value: json);
  }

  @override
  Future clearSavedLocation() async {
    await localStorage.remove(key: _savedLocationKey);
  }
}
