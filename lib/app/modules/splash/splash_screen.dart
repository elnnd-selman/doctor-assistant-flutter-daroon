import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hezr/app/controllers/local_storage_controller.dart';
import 'package:hezr/app/routes/app_routes.dart';
import 'package:hezr/generated/assets.dart';
import 'package:hezr/global/constants/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteBGColor,
      body: Center(
        child: Image.asset(
          Assets.appLogo,
          width: 90,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _handleNavigation();
  }

  void _handleNavigation() async {
    await Future.delayed(const Duration(seconds: 3));

    if (Get.find<LocalStorageController>().daroonBox!.get("isLogin") != null) {
      if (Get.find<LocalStorageController>().daroonBox!.get("isLogin")!) {
        Get.offAllNamed(Routes.userdrawerScreen);
      } else {
        Get.offAllNamed(Routes.onboarding);
      }
    } else {
      Get.offAllNamed(Routes.onboarding);
    }
  }
}
