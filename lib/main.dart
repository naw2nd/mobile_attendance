import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_attendance/initial_bindings.dart';
import 'package:mobile_attendance/module/home/presentation/page/home_page.dart';

void main() {
  runApp(const AttendacePage());
}

class AttendacePage extends StatelessWidget {
  const AttendacePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Mobile Attendance',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
      initialBinding: InitalBindings(),
    );
  }
}
