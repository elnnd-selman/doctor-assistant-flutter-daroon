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
  // RxInt currentPage = 0.obs;
  RxInt totalPages = 1.obs;
  RxBool isLoading = false.obs;
  RxBool processing = false.obs;

  void selectTab(int value) {
    _selectedTab.value = value;
  }

  // Rxn<ContentModel> contentModelList = Rxn();
  RxList<ContentData> contentModelList = <ContentData>[].obs;
  RxList<String> getPostType = [
    "All Posts",
    "Image",
    "Videos",
    "Text",
  ].obs;

  RxString selecetdPostType = 'All Posts'.obs;

  RxInt currentRecord = 0.obs;
  RxInt currentPage = 1.obs;
  RxInt totalRecord = RxInt(-1);

  getDoctorPost({
    required String postType,
  }) async {
    isLoading.value = true;
    currentPage.value = 1;
    currentRecord.value = 0;
    contentModelList.value = [];

    try {
      if (kDebugMode) {
        print(Get.find<DoctorHomeController>().userModel.value!.user!.id);
        print(Get.find<DoctorHomeController>().userModel.value!.token!);
      }

      final response = await ApiService.getwithUserToken(
        endPoint:
            '${AppTokens.apiURl}/contents/my-contents?pagination=1&limit=10&contentType=${postType == 'All Posts' ? 'post' : postType.toLowerCase()}',
        userToken: {
          "Authorization":
              "Bearer ${Get.find<DoctorHomeController>().userModel.value!.token!}",
        },
      );
      if (response!.statusCode == 200 || response.statusCode == 201) {
        final jsonData = jsonDecode(response.body);

        RxList<ContentData> tempList = <ContentData>[].obs;

        totalRecord.value = jsonData["totalRecord"];

        tempList.value = List<ContentData>.from(
            jsonData["data"]!.map((x) => ContentData.fromJson(x)));

        contentModelList = contentModelList + tempList;
        currentRecord.value = contentModelList.length;
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

  postInApiReFetch(String postType) async {
    currentPage = currentPage + 1;

    final response = await ApiService.getwithUserToken(
      endPoint:
          '${AppTokens.apiURl}/contents/my-contents?pagination=$currentPage&limit=10&contentType=$postType',
      userToken: {
        "Authorization":
            "Bearer ${Get.find<DoctorHomeController>().userModel.value!.token!}",
      },
    );
    if (response!.statusCode == 200 || response.statusCode == 201) {
      final jsonData = jsonDecode(response.body);
      final tempList = <ContentData>[].obs;

      tempList.value = List<ContentData>.from(
          jsonData["data"]!.map((x) => ContentData.fromJson(x)));

      contentModelList = contentModelList + tempList;
      currentRecord.value = contentModelList.length;
    }
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
        endPoint: '${AppTokens.apiURl}/likes/contents/${contentData.id}',
        body: {});
    if (response != null) {
      if (response.statusCode == 201 || response.statusCode == 200) {
        if (contentModelList[index].isLiked!) {
          contentModelList[index].isLiked = false;
          contentModelList[index].likes = contentModelList[index].likes! - 1;
        } else {
          contentModelList[index].isLiked = true;
          contentModelList[index].likes = contentModelList[index].likes! + 1;
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
      endPoint: '${AppTokens.apiURl}/doctors/profile',
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
      endPoint: '${AppTokens.apiURl}/contents/${contentData.id}/delete',
      body: {},
    );

    if (response != null) {
      if (response.statusCode == 200 || response.statusCode == 201) {
        contentModelList.removeWhere((val) => val.id == contentData.id);
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

  ScrollController scrollController = ScrollController();
  RxBool reFetchLoader = false.obs;

  Future<void> _loadMoreData() async {
    if (selectedTab == 1) {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (contentModelList.isNotEmpty) {
          if (totalRecord.value != currentRecord.value &&
              currentRecord < totalRecord.value) {
            reFetchLoader.value = true;
            await postInApiReFetch(selecetdPostType.value == 'All Posts'
                ? 'post'
                : selecetdPostType.value.toLowerCase());
          }
        }

        reFetchLoader.value = false;
      }
    } else {
      print("No");
    }
  }

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(_loadMoreData);
  }
}
