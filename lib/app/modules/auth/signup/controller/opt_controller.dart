import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hezr/app/routes/app_routes.dart';
import 'package:hezr/global/constants/app_tokens.dart';
import 'package:hezr/global/widgets/toast_message.dart';
import 'package:hezr/services/api.dart';

class OptController extends GetxController {
  RxInt startDuration = 60.obs;
  RxString otpCode = "".obs;

  final _processing = false.obs;
  bool get processing => _processing.value;

  void _startTimer() {
    const oneSec = Duration(seconds: 1);
    Timer.periodic(
      oneSec,
      (Timer timer) {
        if (startDuration.value == 0) {
          timer.cancel();
        } else {
          startDuration--;
        }
      },
    );
  }

  @override
  void onInit() {
    super.onInit();
    _startTimer();
  }

  resendCode(String userToken, BuildContext context) async {
    startDuration.value = 60;
    _startTimer();
    final response = await ApiService.postwithOutHeader(
        userToken: {"Authorization": userToken},
        endPoint: '${AppTokens.apiURl}/users/sendVerificationCodeViaEmail',
        body: {});
    if (response != null) {
      if (response.statusCode == 201 || response.statusCode == 200) {
        showToastMessage(
            message: "Successfully Send Otp Code",
            // ignore: use_build_context_synchronously
            context: context,
            color: const Color(0xff5BA66B),
            icon: Icons.check);
      } else {
        showToastMessage(
            message: response.body,
            // ignore: use_build_context_synchronously
            context: context,
            color: const Color(0xffEC1C24),
            icon: Icons.close);
      }
    } else {
      showToastMessage(
          message: "Issue while sending Otp Try Again",
          // ignore: use_build_context_synchronously
          context: context,
          color: const Color(0xffEC1C24),
          icon: Icons.close);
    }
  }

  verifyOtpCode({
    required String code,
    required BuildContext context,
    required String userToken,
  }) async {
    _processing.value = true;
    final response = await ApiService.postwithOutHeader(
        userToken: {"Authorization": userToken},
        endPoint: '${AppTokens.apiURl}/users/verifyPhone/$code',
        body: {});

    if (response != null) {
      if (response.statusCode == 201 || response.statusCode == 201) {
        showToastMessage(
            message: "Successfully Verify Code",
            // ignore: use_build_context_synchronously
            context: context,
            color: const Color(0xff5BA66B),
            icon: Icons.check);
        _processing.value = false;
        Get.offAllNamed(Routes.profilePic, arguments: {
          "userToken": userToken,
        });
      } else {
        _processing.value = false;
        showToastMessage(
            message: response.body,
            // ignore: use_build_context_synchronously
            context: context,
            color: const Color(0xffEC1C24),
            icon: Icons.close);
      }
    } else {
      _processing.value = false;
      showToastMessage(
          message: response!.body,
          // ignore: use_build_context_synchronously
          context: context,
          color: const Color(0xffEC1C24),
          icon: Icons.close);
    }
  }
}
