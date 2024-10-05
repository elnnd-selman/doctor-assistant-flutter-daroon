import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:daroon_doctor/app/controllers/local_storage_controller.dart';
import 'package:daroon_doctor/app/model/user_model.dart';
import 'package:daroon_doctor/app/routes/app_routes.dart';
import 'package:daroon_doctor/global/constants/app_tokens.dart';
import 'package:daroon_doctor/global/widgets/toast_message.dart';
import 'package:daroon_doctor/services/api.dart';

class LoginCtrl extends GetxController {
  final email = TextEditingController();
  final password = TextEditingController();

  final _processing = false.obs;
  bool get processing => _processing.value;

  Future<void> loginUser(BuildContext context) async {
    try {
      _processing.value = true;
      FocusManager.instance.primaryFocus?.unfocus();

      final response = await ApiService.post(
          endPoint: '${AppTokens.apiURl}/users/login',
          body: {
            "emailOrPhoneOrUsername": email.text,
            "password": password.text
          });

      if (response != null) {
        // prin
        if (response.statusCode == 201 || response.statusCode == 200) {
          showToastMessage(
              message: "Successfully login.",
              context: context,
              color: const Color(0xff5BA66B),
              icon: Icons.check);
          final jsonData = jsonDecode(response.body);

          Get.find<LocalStorageController>().daroonBox!.put("isLogin", true);

          final userModel = UserModel.fromJson(jsonData);

          Get.find<LocalStorageController>()
              .daroonBox!
              .put("userModel", userModel);

          Get.find<LocalStorageController>()
              .daroonBox!
              .put("userRole", userModel.user!.typeOfUser!);
          if (jsonData["typeOfUser"] == "user") {
            Get.offAllNamed(Routes.userdrawerScreen);
          } else {
            Get.offAllNamed(Routes.doctordrawerScreen);
          }
          cleanController();
          _processing.value = false;
        } else {
          _processing.value = false;
          showToastMessage(
              message: response.body,
              context: context,
              color: const Color(0xffEC1C24),
              icon: Icons.close);
        }
      } else {
        _processing.value = false;
        showToastMessage(
            message: response!.body,
            context: context,
            color: const Color(0xffEC1C24),
            icon: Icons.close);
      }
    } catch (e) {
      _processing.value = false;
      showToastMessage(
          message: "Issue ${e.toString()}",
          context: context,
          color: const Color(0xffEC1C24),
          icon: Icons.close);
    }
  }

  cleanController() {
    email.clear();
    password.clear();
  }
}
