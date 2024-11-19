import 'dart:convert';

import 'package:daroon_doctor/app/modules/doctor/doctor_home/controller/doctor_home_controller.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_profile/model/like_user_model.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_profile/model/post_model.dart';
import 'package:daroon_doctor/global/constants/app_tokens.dart';
import 'package:daroon_doctor/services/api.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostLikeUserController extends GetxController {
  RxList<LikeUserModelData> likeUserModelList = <LikeUserModelData>[].obs;
  RxBool isLoading = false.obs;
  final TextEditingController userName = TextEditingController();

  setPostData(ContentData contentData) {
    getPostLikeUsers(contentID: contentData.id!);
  }

  getPostLikeUsers({
    required String contentID,
  }) async {
    isLoading.value = true;

    try {
      if (kDebugMode) {
        print(Get.find<DoctorHomeController>().userModel.value!.user!.id);
        print(Get.find<DoctorHomeController>().userModel.value!.token!);
      }

      final response = await ApiService.getwithUserToken(
        endPoint: '${AppTokens.apiURl}/contents/$contentID/likes/users',
        userToken: {
          "Authorization":
              "Bearer ${Get.find<DoctorHomeController>().userModel.value!.token!}",
        },
      );
      if (response!.statusCode == 200 || response.statusCode == 201) {
        final jsonData = jsonDecode(response.body);

        likeUserModelList.value = List<LikeUserModelData>.from(
            jsonData["data"]!.map((x) => LikeUserModelData.fromJson(x)));
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

  RxList<LikeUserModelData> searchUserList = <LikeUserModelData>[].obs;
  RxBool isSearch = false.obs;
  searchUser(String query) {
    searchUserList.value = [];
    searchUserList.value = likeUserModelList
        .where((item) => item.firstName!.contains(query.toLowerCase()))
        .toList();
  }
}
