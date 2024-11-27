import 'package:daroon_doctor/app/modules/doctor/doctor_home/controller/doctor_home_controller.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_profile/controller/doctor_edit_profile_controller.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_profile/controller/doctor_profile_controller.dart';
import 'package:daroon_doctor/global/constants/app_tokens.dart';
import 'package:daroon_doctor/global/utils/json_message_extension.dart';
import 'package:daroon_doctor/global/widgets/toast_message.dart';
import 'package:daroon_doctor/services/api.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddEducationController extends GetxController {
  final _processing = false.obs;
  bool get processing => _processing.value;
  TextEditingController degreeKU = TextEditingController();
  TextEditingController degreeEN = TextEditingController();
  TextEditingController degreeAR = TextEditingController();

  TextEditingController instituteKu = TextEditingController();
  TextEditingController instituteEN = TextEditingController();
  TextEditingController instituteAR = TextEditingController();
  Rxn<DateTime> fromYear = Rxn(null);
  Rxn<DateTime> toYear = Rxn(null);

  String formatDate(DateTime date) {
    DateFormat formatter = DateFormat('MMM-yy');
    String formattedDate = formatter.format(date);
    return formattedDate;
  }

  String formatDateOnlyYear(DateTime date) {
    DateFormat formatter = DateFormat('yyyy');
    String formattedDate = formatter.format(date);
    return formattedDate;
  }

  addDoctorEducation(BuildContext context) async {
    try {
      _processing.value = true;
      final onlyFromYear = formatDateOnlyYear(fromYear.value!);
      final onlyToYear = formatDateOnlyYear(toYear.value!);
      final response = await ApiService.postWithHeader(
        userToken: {
          'Content-Type': 'application/json',
          "Authorization":
              "Bearer ${Get.find<DoctorHomeController>().userModel.value!.token!}",
        },
        endPoint: '${AppTokens.apiURl}/doctors/educations',
        body: {
          "degree": 83,
          "fromYear": onlyFromYear,
          "toYear": onlyToYear,
          "institute_ar": instituteAR.text,
          "institute_en": instituteEN.text,
          "institute_ku": instituteKu.text,
          "degreeName_ar": degreeAR.text,
          "degreeName_en": degreeEN.text,
          "degreeName_ku": degreeKU.text
        },
      );

      if (response != null) {
        if (response.statusCode == 200 || response.statusCode == 201) {
          Get.find<DoctorEditProfileController>().getUserProfileData();
          Get.find<DoctorEditProfileController>().imageUrl.value = '';
          Get.find<DoctorProfileController>().getUserProfileData();
          Get.back();
          _processing.value = false;
          showToastMessage(
              message: "Successfully added Education",
              // ignore: use_build_context_synchronously
              context: context,
              color: const Color(0xff5BA66B),
              icon: Icons.check);
        } else {
          _processing.value = false;
          printInfo(info: "Error While Updating  Eduatuion ${response.body}");
          showToastMessage(
              message: response.body.extractErrorMessage(),
              // ignore: use_build_context_synchronously
              context: context,
              color: const Color(0xffEC1C24),
              icon: Icons.close);
        }
      }
    } catch (e) {
      _processing.value = false;
      showToastMessage(
          message: e.toString(),
          // ignore: use_build_context_synchronously
          context: context,
          color: const Color(0xffEC1C24),
          icon: Icons.close);
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  checkValidation(BuildContext context) {
    if (degreeAR.text.isEmpty ||
        degreeEN.text.isEmpty ||
        degreeKU.text.isEmpty ||
        instituteAR.text.isEmpty ||
        instituteEN.text.isEmpty ||
        instituteKu.text.isEmpty ||
        fromYear.value == null ||
        toYear.value == null) {
      if (degreeEN.text.isEmpty) {
        showToastMessage(
            message: "Enter Degree Name-En",
            context: context,
            color: const Color(0xffEC1C24),
            icon: Icons.close);
        return;
      } else if (degreeAR.text.isEmpty) {
        showToastMessage(
            message: "Enter Degree Name-Ar",
            context: context,
            color: const Color(0xffEC1C24),
            icon: Icons.close);
        return;
      } else if (degreeKU.text.isEmpty) {
        showToastMessage(
            message: "Enter Degree Name-ku",
            context: context,
            color: const Color(0xffEC1C24),
            icon: Icons.close);
        return;
      } else if (instituteAR.text.isEmpty) {
        showToastMessage(
            message: "Enter Institute Name-Ar...",
            context: context,
            color: const Color(0xffEC1C24),
            icon: Icons.close);
        return;
      } else if (instituteEN.text.isEmpty) {
        showToastMessage(
            message: "Enter Institute Name-En...",
            context: context,
            color: const Color(0xffEC1C24),
            icon: Icons.close);
        return;
      } else if (instituteKu.text.isEmpty) {
        showToastMessage(
            message: "Enter Institute Name-ku...",
            context: context,
            color: const Color(0xffEC1C24),
            icon: Icons.close);
        return;
      } else if (fromYear.value == null) {
        showToastMessage(
            message: "Select Degree Start Date",
            context: context,
            color: const Color(0xffEC1C24),
            icon: Icons.close);
        return;
      } else if (toYear.value == null) {
        showToastMessage(
            message: "Select Degree End Date",
            context: context,
            color: const Color(0xffEC1C24),
            icon: Icons.close);
        return;
      }
    } else {
      FocusManager.instance.primaryFocus?.unfocus();

      addDoctorEducation(context);
    }
  }
}
