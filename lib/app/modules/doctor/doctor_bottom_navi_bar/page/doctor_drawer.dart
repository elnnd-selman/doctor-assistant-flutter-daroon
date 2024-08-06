import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_bottom_navi_bar/page/doctor_bottom_navi_bar.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_bottom_navi_bar/widget/doctor_drawer_option.dart';
import 'package:daroon_doctor/app/routes/app_routes.dart';
import 'package:daroon_doctor/global/constants/app_colors.dart';

class DoctorDrawerScreen extends StatelessWidget {
  const DoctorDrawerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      controller: ZoomDrawerController(),
      menuScreen: DoctorDrawerOption(
        setIndex: (index) {
          if (index == 0) {
            Get.toNamed(Routes.doctorOffers);
          } else if (index == 1) {
            Get.toNamed(Routes.doctorAssistant);
          }
        },
      ),
      mainScreen: const DoctorBottomNaviBar(),
      borderRadius: 40,
      mainScreenScale: 0.3,
      showShadow: true,
      angle: 0,
      drawerShadowsBackgroundColor: const Color(0xff3893ff),
      slideWidth: 280,
      shadowLayer2Color: Colors.transparent,
      shadowLayer1Color: const Color(0xff3893ff),
      // overlayBlend: BlendMode.difference,
      menuBackgroundColor: AppColors.primaryColor,
    );
  }
}
