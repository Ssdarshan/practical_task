import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practical_task/views/home_screen.dart';

import 'bindings/app_bindings.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      home: HomeScreen(),
      initialBinding: AppBinding(),
    );
  }
}
