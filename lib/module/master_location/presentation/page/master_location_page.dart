import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_attendance/module/master_location/presentation/controller/master_location_controller.dart';
import 'package:mobile_attendance/package_handler/location_manager/domain/entity/location_result.dart';

class MasterLocationPage extends StatelessWidget {
  final MasterLocationController controller =
      Get.put(MasterLocationController());

  MasterLocationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Master Location'),
        actions: [
          IconButton(
              onPressed: () {
                controller.clearSavedLocation();
              },
              icon: const Icon(Icons.delete))
        ],
      ),
      body: Container(
        margin: const EdgeInsets.all(20).copyWith(top: 10),
        child: Card(
          child: Container(
            padding: const EdgeInsets.all(15),
            width: double.maxFinite,
            child: Obx(() {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Latitude: ${controller.savedLocation.value.latitude}'),
                  Text(
                      'Longitude: ${controller.savedLocation.value.longitude}'),
                ],
              );
            }),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.edit),
          onPressed: () async {
            final LocationResult? result =
                await Get.dialog(AddNewLocationDialog(
              defaultLocation: controller.initalLocation.value,
            ));
            if (result != null) {
              controller.setSavedLocation(location: result);
            }
          }),
    );
  }
}

class AddNewLocationDialog extends StatefulWidget {
  const AddNewLocationDialog({super.key, this.defaultLocation});

  final LocationResult? defaultLocation;

  @override
  State<AddNewLocationDialog> createState() => _AddNewLocationDialogState();
}

class _AddNewLocationDialogState extends State<AddNewLocationDialog> {
  final latitude = TextEditingController();
  final longitude = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.defaultLocation != null) {
      latitude.text = widget.defaultLocation!.latitude.toString();
      longitude.text = widget.defaultLocation!.longitude.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: latitude,
              decoration: const InputDecoration(label: Text('Latitude')),
            ),
            TextField(
              controller: longitude,
              decoration: const InputDecoration(label: Text('Longitude')),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.maxFinite,
              child: ElevatedButton(
                  onPressed: () {
                    final result = LocationResult(
                      latitude: double.tryParse(latitude.text) ?? 0,
                      longitude: double.tryParse(longitude.text) ?? 0,
                    );
                    Get.back(result: result);
                  },
                  child: const Text('Add')),
            )
          ],
        ),
      ),
    );
  }
}
