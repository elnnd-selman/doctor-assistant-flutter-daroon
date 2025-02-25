import 'package:daroon_doctor/app/modules/doctor/doctor_home/controller/doctor_home_controller.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_profile/controller/doctor_edit_profile_controller.dart';
import 'package:daroon_doctor/generated/assets.dart';
import 'package:daroon_doctor/global/constants/app_tokens.dart';
import 'package:daroon_doctor/global/utils/app_text_style.dart';
import 'package:daroon_doctor/global/utils/json_message_extension.dart';
import 'package:daroon_doctor/global/utils/widget_spacing.dart';
import 'package:daroon_doctor/global/widgets/toast_message.dart';
import 'package:daroon_doctor/services/api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class DoctorChangeUserNameController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isError = false.obs;

  final Rx<TextEditingController> userName = TextEditingController().obs;

  setUserName(emails) {
    userName.value.text = emails;
  }

  updateDoctorUserName({
    required BuildContext context,
  }) async {
    try {
      isLoading.value = true;
      final response = await ApiService.putWithHeader(
          userToken: {
            'Content-Type': 'application/json',
            "Authorization":
                "Bearer ${Get.find<DoctorHomeController>().userModel.value!.token!}",
          },
          endPoint: '${AppTokens.apiURl}/doctors',
          body: {
            "username": userName.value.text,
          });

      if (response != null) {
        if (response.statusCode == 200 || response.statusCode == 201) {
          Get.back();
          Get.find<DoctorEditProfileController>().getUserProfileData();
          Get.find<DoctorEditProfileController>().imageUrl.value = '';
          Get.dialog(
            CupertinoAlertDialog(
              title: Column(
                children: [
                  10.verticalSpace,
                  SvgPicture.asset(
                    Assets.doneIcon,
                  ),
                  10.verticalSpace,
                  Text(
                    'All Done !',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.bold.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  10.verticalSpace,
                ],
              ),
              content: Column(
                children: [
                  Text(
                    "You change your User Name \nsuccessfully !",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xff979797),
                    ),
                  ),
                  10.verticalSpace,
                ],
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Get.back(),
                  child: Text(
                    'Close',
                    style: AppTextStyles.bold.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xff717171),
                    ),
                  ),
                ),
              ],
            ),
            barrierColor: Colors.black54,
          );
        } else {
          isError.value = true;
          showToastMessage(
              message: response.body.extractErrorMessage(),
              context: context,
              color: const Color(0xffEC1C24),
              icon: Icons.close);
          printInfo(info: "Error While Updating  User-Name  ${response.body}");
        }
      }
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      printInfo(info: e.toString());
    }
  }

  updateUi(String value) {
    isError.value = false;
    userName.value.text = value;
    update();
  }
}
