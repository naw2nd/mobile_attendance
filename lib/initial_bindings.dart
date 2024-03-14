import 'package:get/get.dart';
import 'package:mobile_attendance/package_handler/local_storage/data/local_storage_impl.dart';
import 'package:mobile_attendance/package_handler/local_storage/domain/local_storage.dart';
import 'package:mobile_attendance/package_handler/location_manager/data/location_manager_impl.dart';
import 'package:mobile_attendance/package_handler/location_manager/domain/location_manager.dart';

class InitalBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<LocalStorage>(LocalStorageImpl(), permanent: true);
    Get.put<LocationManager>(LocationManagerImpl(isAllowMocked: true),
        permanent: true);
  }
}
