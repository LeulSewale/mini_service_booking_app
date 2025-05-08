import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mini_service_booking_app/routes/app_pages.dart';
import 'package:mini_service_booking_app/routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('servicesBox');

  runApp(GetMaterialApp(
    title: 'Mini Service Booking App',
    initialRoute: AppRoutes.login,
    getPages: AppPages.routes,
    debugShowCheckedModeBanner: false,
  ));
}
