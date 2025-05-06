import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:mini_service_booking_app/presentation/pages/home_page.dart';

import '../core/bindings/service_binding.dart';
import '../presentation/pages/add_service_page.dart';
import 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: '/',
      page: () => HomePage(),
      binding: ServiceBinding(),
    ),
    GetPage(
  name: AppRoutes.addService,
  page: () => AddServicePage(),
  binding: ServiceBinding(),
),
    // Add other pages here...
  ];
}
