import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hezr/app/controllers/local_storage_controller.dart';
import 'package:hezr/global/constants/app_colors.dart';

class DoctorHomeController extends GetxController {
  RxInt isSelected = 0.obs;

  final _selectedTab = 0.obs;
  int get selectedTab => _selectedTab.value;

  void selectTab(int value) async {
    _selectedTab.value = value;
  }

  List<Color> gradientColors = [
    AppColors.primaryColor,
    AppColors.primaryColor,
  ];

  // @override
  // void onInit() {
  //   super.onInit();
  //   Get.find<LocalStorageController>().daroonBox!.delete("isLogin");
  // }
}
