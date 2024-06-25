import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddAssistantController extends GetxController {
  RxList<String> genderList = ['Male', 'Female'].obs;
  RxList<String> premissionList = ['Manage Appointments', 'Manage Posts'].obs;
  RxString selectedGender = 'Gender'.obs;
  RxString selectedPremission = 'Premission'.obs;

  TextEditingController userName = TextEditingController();
}
