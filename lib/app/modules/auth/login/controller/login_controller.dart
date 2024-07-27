import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hezr/app/controllers/local_storage_controller.dart';
import 'package:hezr/app/model/user_model.dart';
import 'package:hezr/app/routes/app_routes.dart';
import 'package:hezr/global/constants/app_tokens.dart';
import 'package:hezr/global/widgets/toast_message.dart';
import 'package:hezr/services/api.dart';

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
        if (response.statusCode == 201) {
          
          showToastMessage(
              message: "Successfully login.",
              context: context,
              color: const Color(0xff5BA66B),
              icon: Icons.check);
          final jsonData = jsonDecode(response.body);

          Get.find<LocalStorageController>().daroonBox!.put("isLogin", true);

          final userModel = UserModel.fromJson(jsonData);
          print(jsonData);
          Get.find<LocalStorageController>()
              .daroonBox!
              .put("userModel", userModel);
          print("Checkin ${jsonData["typeOfUser"]}");
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
          message: "Issue",
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
