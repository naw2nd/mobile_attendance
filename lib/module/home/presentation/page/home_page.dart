import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_attendance/module/attendance/presentation/page/submit_attendance_page.dart';
import 'package:mobile_attendance/module/master_location/presentation/page/master_location_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  Get.to(() => MasterLocationPage());
                },
                child: const Text('Go to Master Location Page')),
            ElevatedButton(
                onPressed: () {
                  Get.to(() => SubmitAttendancePage());
                },
                child: const Text('Go to Attendance Page')),
          ],
        ),
      ),
    );
  }
}
