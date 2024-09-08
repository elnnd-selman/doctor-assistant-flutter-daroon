import 'dart:convert';

import 'package:daroon_doctor/app/modules/doctor/doctor_assistant/model/user_search_model.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_home/controller/doctor_home_controller.dart';
import 'package:daroon_doctor/global/constants/app_tokens.dart';
import 'package:daroon_doctor/global/widgets/toast_message.dart';
import 'package:daroon_doctor/services/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

class AddAssistantController extends GetxController {
  RxList<String> genderList = ['Male', 'Female'].obs;
  RxList<String> premissionList = ['Manage Appointments', 'Manage Posts'].obs;
  RxString selectedGender = 'Gender'.obs;
  RxString selectedPremission = 'Premission'.obs;

  RxList selectedPremissionList = [].obs;

  TextEditingController userName = TextEditingController();
  TextEditingController searchUser = TextEditingController();

  final MultiSelectController multiSelectController = MultiSelectController();

  RxInt selectedIndex = RxInt(-1);
  RxString selectedAddress = "".obs;
  RxString selectedAddressID = "".obs;

  RxInt selectedUserIndex = RxInt(-1);

  RxString selectedUserID = "".obs;
  RxString selectedUserName = "".obs;

  ScrollController scrollController = ScrollController();
  String toCamelCase(String input) {
    List<String> words = input.split(' ');

    List<String> camelCaseWords = words.asMap().entries.map((entry) {
      int index = entry.key;
      String word = entry.value;

      if (index == 0) {
        return word.toLowerCase();
      } else {
        return word[0].toUpperCase() + word.substring(1).toLowerCase();
      }
    }).toList();

    return camelCaseWords.join('');
  }

  final _processing = false.obs;
  bool get processing => _processing.value;
  Future<void> createAssistant(BuildContext context) async {
    try {
      _processing.value = true;
      FocusManager.instance.primaryFocus?.unfocus();
      print(selectedAddressID);
      print(selectedUserID);
      print(selectedPremissionList);
      final tempStringList = [];
      for (int i = 0; i < selectedPremissionList.length; i++) {
        tempStringList.add(convertText(selectedPremissionList[i]));
      }

      final response = await ApiService.postWithHeader(
        userToken: {
          'Content-Type': 'application/json',
          'Authorization':
              "Bearer ${Get.find<DoctorHomeController>().userModel.value!.token!}",
        },
        endPoint: '${AppTokens.apiURl}/assistants',
        body: {
          "userId": selectedUserID.value,
          "office": selectedAddressID.value,
          "permissions": tempStringList,
        },
      );

      if (response != null) {
        if (response.statusCode == 201 || response.statusCode == 200) {
          showToastMessage(
              message: "Successfully register.",
              context: context,
              color: const Color(0xff5BA66B),
              icon: Icons.check);
          final jsonData = jsonDecode(response.body)['data'];

          print(jsonData);
          Get.back();
          Get.back();
          Get.back();

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
      print(e.toString());
      _processing.value = false;
      showToastMessage(
          message: "Issue ${e.toString()}",
          context: context,
          color: const Color(0xffEC1C24),
          icon: Icons.close);
    }
  }

  String convertText(String input) {
    List<String> words = input.split(' ');
    String firstWord = words[0].toLowerCase();
    String secondWord = words[1].capitalizeFirstLetter();
    return firstWord + secondWord;
  }

  // Rxn<UserSearchModel> userSearchModelList = Rxn();
  RxList<UserSearchDataModel> userSearchModelList = <UserSearchDataModel>[].obs;
  RxInt totalRecord = RxInt(-1);

  RxInt currentRecord = 0.obs;
  RxInt currentPage = 1.obs;

  RxBool isFirstRequest = false.obs;

  RxBool isLoading = false.obs;
  RxBool reFetchLoader = false.obs;
  searchUserInApi(String searchText) async {
    userSearchModelList.value = [];
    currentPage.value = 1;
    currentRecord.value = 0;
    isLoading.value = true;

    final response = await ApiService.getwithUserToken(
      endPoint:
          '${AppTokens.apiURlWithOutApi}/users/list-users?pagination=1&searchQuery=$searchText&limit=10',
      userToken: {
        "Authorization":
            "Bearer ${Get.find<DoctorHomeController>().userModel.value!.token!}",
      },
    );
    if (response!.statusCode == 200 || response.statusCode == 201) {
      final jsonData = jsonDecode(response.body);
      RxList<UserSearchDataModel> tempList = <UserSearchDataModel>[].obs;

      totalRecord.value = jsonData["totalRecord"];

      tempList.value = List<UserSearchDataModel>.from(
          jsonData["data"]!.map((x) => UserSearchDataModel.fromJson(x)));

      userSearchModelList = userSearchModelList + tempList;
      currentRecord.value = userSearchModelList.length;
    }
    isLoading.value = false;
  }

  searchUserInApiReFetch(String searchText) async {
    currentPage = currentPage + 1;
    final response = await ApiService.getwithUserToken(
      endPoint:
          '${AppTokens.apiURlWithOutApi}/users/list-users?pagination=$currentPage&searchQuery=$searchText&limit=10',
      userToken: {
        "Authorization":
            "Bearer ${Get.find<DoctorHomeController>().userModel.value!.token!}",
      },
    );
    if (response!.statusCode == 200 || response.statusCode == 201) {
      final jsonData = jsonDecode(response.body);
      final tempList = <UserSearchDataModel>[].obs;

      tempList.value = List<UserSearchDataModel>.from(
          jsonData["data"]!.map((x) => UserSearchDataModel.fromJson(x)));

      userSearchModelList = userSearchModelList + tempList;
      currentRecord.value = userSearchModelList.length;
    }
  }

  Future<void> _loadMoreData() async {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      if (userSearchModelList.isNotEmpty) {
        if (totalRecord.value != currentRecord.value &&
            currentRecord < totalRecord.value) {
          reFetchLoader.value = true;
          await searchUserInApiReFetch(searchUser.text);
        }
      }

      reFetchLoader.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(_loadMoreData);
  }
}

extension StringExtension on String {
  String capitalizeFirstLetter() {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1);
  }
}
