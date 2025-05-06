import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'routes/app_pages.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Mini Service Booking App',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      getPages: AppPages.routes,
    );
  }
}
