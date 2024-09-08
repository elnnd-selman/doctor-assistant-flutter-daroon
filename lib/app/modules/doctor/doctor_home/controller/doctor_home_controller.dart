import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:daroon_doctor/app/controllers/local_storage_controller.dart';
import 'package:daroon_doctor/app/model/user_model.dart';
import 'package:daroon_doctor/global/constants/app_colors.dart';

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

  Rxn<UserModel> userModel = Rxn();

  @override
  Future<void> onInit() async {
    super.onInit();
    // Get.find<LocalStorageController>().daroonBox!.delete("isLogin");

    userModel.value = await Get.find<LocalStorageController>()
        .daroonBox!
        .get("userModel", defaultValue: UserModel);
    print(userModel.value!.token!);
    print(userModel.value!.user!.id!);
  }
}
