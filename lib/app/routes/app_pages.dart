import 'package:get/get.dart';
import 'package:hezr/app/modules/splash/splash_screen.dart';
import 'package:hezr/app/routes/app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.splash;

  static final routes = [
    GetPage(
      name: Routes.splash,
      page: () => const SplashScreen(),
    ),
  ];
}
