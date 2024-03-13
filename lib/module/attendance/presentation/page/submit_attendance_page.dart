import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_attendance/module/attendance/presentation/controller/submit_attendance_controller.dart';

class SubmitAttendancePage extends StatelessWidget {
  SubmitAttendancePage({super.key});
  final SubmitAttendanceController controller =
      Get.put(SubmitAttendanceController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Attendance'),
        actions: [
          IconButton(
              onPressed: () {
                controller.clearSavedAttendances();
              },
              icon: const Icon(Icons.delete))
        ],
      ),
      body: Container(
        margin: const EdgeInsets.all(20).copyWith(top: 10),
        child: Obx(() {
          return ListView(
            children: [
              ...controller.savedAttendances.map(
                (element) => Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Card(
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Latitude: ${element.location.latitude}'),
                          Text('Longitude: ${element.location.longitude}'),
                          Text('Jarak: ${element.distance}')
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () async {
            controller.saveAttendance();
          }),
    );
  }
}
