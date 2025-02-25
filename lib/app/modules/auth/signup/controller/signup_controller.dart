// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:country_phone_validator/country_phone_validator.dart';
import 'package:daroon_doctor/global/utils/json_message_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:daroon_doctor/app/controllers/local_storage_controller.dart';
import 'package:daroon_doctor/app/model/user_model.dart';
import 'package:daroon_doctor/app/routes/app_routes.dart';
import 'package:daroon_doctor/global/constants/app_tokens.dart';
import 'package:daroon_doctor/global/widgets/toast_message.dart';
import 'package:daroon_doctor/services/api.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class SignUpCtrl extends GetxController {
  RxString selectedGender = 'Gender'.obs;
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final email = TextEditingController();
  final userName = TextEditingController();
  final password = TextEditingController();
  final confirmpassword = TextEditingController();
  final phone = TextEditingController();
  final _processing = false.obs;
  bool get processing => _processing.value;

  RxBool phoneEmpty = false.obs;
  var phoneNumberFormat =
      PhoneNumber(phoneNumber: "*******", isoCode: "IQ", dialCode: "+964");

  Rx<String> dialCode = "+964".obs;
  Rx<String> errorMessage = "Enter Phone Number".obs;

  // var userModel = Rxn<Users>();

  RxList<String> genderList = ['Male', 'Female'].obs;

  checkPhoneValidation(String phoneNumber, String dialCode) {
    bool isValid = CountryUtils.validatePhoneNumber(phoneNumber, dialCode);

    if (isValid) {
      phoneEmpty.value = false;
    } else {
      phoneEmpty.value = true;
      errorMessage.value = "Phone number is invalid";
    }
  }

  Future<void> registerUser(BuildContext context) async {
    try {
      _processing.value = true;
      FocusManager.instance.primaryFocus?.unfocus();

      String newText = phone.text.replaceAll(' ', '');
      final response = await ApiService.post(
          endPoint: '${AppTokens.apiURl}/users/register',
          body: {
            "name": firstName.text,
            "fullName": "${firstName.text} ${lastName.text}",
            "username": userName.text,
            "gender": selectedGender.value.toLowerCase(),
            "email": email.text,
            "password": password.text,
            "confirmPassword": confirmpassword.text,
            "phoneNumber": "$dialCode$newText"
          });

      if (response != null) {
        if (response.statusCode == 201 || response.statusCode == 200) {
          showToastMessage(
              message: "Successfully register.",
              context: context,
              color: const Color(0xff5BA66B),
              icon: Icons.check);
          final jsonData = jsonDecode(response.body);
          Get.find<LocalStorageController>().daroonBox!.put("isLogin", true);
          await sendOtptoUser(jsonData["token"]);

          await sendOtptoUserInEmail(jsonData["token"]);

          final userModel = UserModel.fromJson(jsonData);
          Get.find<LocalStorageController>()
              .daroonBox!
              .put("userModel", userModel);

          _processing.value = false;

          Get.offAllNamed(Routes.otpScreen, arguments: {
            "userToken": jsonData["token"],
            "email": email.text,
          });
          cleanController();
        } else {
          _processing.value = false;
          showToastMessage(
              message: response.body.extractErrorMessage(),
              context: context,
              color: const Color(0xffEC1C24),
              icon: Icons.close);
        }
      } else {
        _processing.value = false;
        showToastMessage(
            message: "Response is Empty",
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

  sendOtptoUser(String userToken) async {
    await ApiService.postWithHeader(
      userToken: {"Authorization": userToken},
      endPoint:
          '${AppTokens.apiURl}/users/send-verification-code-via-phone-number',
      body: {},
    );
  }

  sendOtptoUserInEmail(String userToken) async {
    await ApiService.postWithHeader(
        userToken: {"Authorization": userToken},
        endPoint: '${AppTokens.apiURl}/users/send-verification-code-via-email',
        body: {});
  }

  cleanController() {
    selectedGender.value = 'Gender';
    firstName.clear();
    lastName.clear();
    email.clear();
    userName.clear();
    password.clear();
    confirmpassword.clear();
    phone.clear();
    phoneEmpty.value = false;
    phoneNumberFormat =
        PhoneNumber(phoneNumber: "*******", isoCode: "IQ", dialCode: "+964");
    dialCode.value = "+964";
    errorMessage.value = "Enter Phone Number";
  }
}
