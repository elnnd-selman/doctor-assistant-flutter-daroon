import 'dart:convert';

import 'package:daroon_doctor/app/modules/doctor/doctor_profile/model/user_profile_model.dart';
import 'package:daroon_doctor/global/widgets/toast_message.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_home/controller/doctor_home_controller.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_profile/model/post_model.dart';
import 'package:daroon_doctor/global/constants/app_tokens.dart';
import 'package:daroon_doctor/services/api.dart';
import 'package:intl/intl.dart';

class DoctorProfileController extends GetxController {
  final _selectedTab = 0.obs;
  int get selectedTab => _selectedTab.value;
  RxInt currentPage = 0.obs;
  RxInt totalPages = 1.obs;
  RxBool isLoading = false.obs;
  RxBool processing = false.obs;

  void selectTab(int value) {
    _selectedTab.value = value;
  }

  Rxn<ContentModel> contentModelList = Rxn();

  getDoctorPost() async {
    isLoading.value = true;

    try {
      if (kDebugMode) {
        print(Get.find<DoctorHomeController>().userModel.value!.user!.id);
        print(Get.find<DoctorHomeController>().userModel.value!.token!);
      }

      final response = await ApiService.getwithUserToken(
        endPoint:
            '${AppTokens.apiURl}/content/my-contents?pagination=1&limit=10&contentType=post',
        userToken: {
          "Authorization":
              "Bearer ${Get.find<DoctorHomeController>().userModel.value!.token!}",
        },
      );
      if (response!.statusCode == 200 || response.statusCode == 201) {
        final jsonData = jsonDecode(response.body);

        contentModelList.value = ContentModel.fromJson(jsonData);
        totalPages.value = contentModelList.value!.paginationCount!;
      } else {
        printError(info: response.body);
      }

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      printInfo(info: e.toString());
    }
    isLoading.value = false;
  }

  String convertDateToformat(String date) {
    DateTime dateTime = DateTime.parse(date);
    DateFormat formatter = DateFormat('dd-MMM-yyyy');
    String formattedDate = formatter.format(dateTime);
    return formattedDate;
  }

  updateLikeOnPost({
    required ContentData contentData,
    required int index,
  }) async {
    final response = await ApiService.postWithHeader(
        userToken: {
          "Authorization":
              "Bearer ${Get.find<DoctorHomeController>().userModel.value!.token!}"
        },
        endPoint: '${AppTokens.apiURl}/likes/${contentData.id}',
        body: {});
    if (response != null) {
      if (response.statusCode == 201 || response.statusCode == 200) {
        if (contentModelList.value!.data[index].isLiked!) {
          contentModelList.value!.data[index].isLiked = false;
          contentModelList.value!.data[index].likes =
              contentModelList.value!.data[index].likes! - 1;
        } else {
          contentModelList.value!.data[index].isLiked = true;
          contentModelList.value!.data[index].likes =
              contentModelList.value!.data[index].likes! + 1;
        }
        contentModelList.refresh();
      } else {
        printInfo(info: "Not Like${response.body}");
      }
    }
  }

  Rxn<UserProfileModel> userProfileModel = Rxn();
  getUserProfileData() async {
    processing.value = true;
    final response = await ApiService.getwithUserToken(
      endPoint: '${AppTokens.apiURl}/users/profile',
      userToken: {
        "Authorization":
            "Bearer ${Get.find<DoctorHomeController>().userModel.value!.token!}",
      },
    );

    if (response!.statusCode == 200 || response.statusCode == 201) {
      final jsonData = jsonDecode(response.body);
      userProfileModel.value = UserProfileModel.fromJson(jsonData);
    } else if (response.statusCode == 401) {
      final jsonData = jsonDecode(response.body);
      if (jsonData["message"] == "unauthorized") {
        Get.find<DoctorHomeController>().signOutUser();
      }
    }
    processing.value = false;
  }

  checkLanguageExist(String langName) {
    bool langExist = false;
    langExist =
        userProfileModel.value!.userProfile!.languages.contains(langName);
    return langExist;
  }

  deletePost(
      {required ContentData contentData,
      required int index,
      required BuildContext context}) async {
    final response = await ApiService.deleteWithHeader(
      userToken: {
        'Content-Type': 'application/json',
        "Authorization":
            "Bearer ${Get.find<DoctorHomeController>().userModel.value!.token!}",
      },
      endPoint: '${AppTokens.apiURl}/content/${contentData.id}/delete',
      body: {},
    );

    if (response != null) {
      if (response.statusCode == 200 || response.statusCode == 201) {
        contentModelList.value!.data
            .removeWhere((val) => val.id == contentData.id);
        contentModelList.refresh();
        showToastMessage(
            message:
                "You send a request for admin to delete this post successfully.",
            context: context,
            color: const Color(0xff5BA66B),
            icon: Icons.check);
      }
    }
  }
}
