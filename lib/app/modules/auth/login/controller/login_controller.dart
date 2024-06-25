import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hezr/app/controllers/local_storage_controller.dart';
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

          Get.find<LocalStorageController>().daroonBox!.put("isLogin", true);
          Get.find<LocalStorageController>().daroonBox!.put("userRole", "");
          cleanController();
          _processing.value = false;
          Get.offAllNamed(Routes.doctordrawerScreen);
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
