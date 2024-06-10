import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
}
