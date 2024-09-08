import 'dart:convert';

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

  void selectTab(int value) {
    _selectedTab.value = value;
  }

  Rxn<ContentModel> contentModelList = Rxn();

  getDoctorPost() async {
    isLoading.value = true;
    print(Get.find<DoctorHomeController>().userModel.value!.token!);
    print(Get.find<DoctorHomeController>().userModel.value!.user!.id);

    final response = await ApiService.getwithUserToken(
      endPoint:
          '${AppTokens.apiURl}/content/my-contents?contentType=post&pagination=1&limit=10',
      userToken: {
        "Authorization":
            "Bearer ${Get.find<DoctorHomeController>().userModel.value!.token!}",
      },
    );
    if (response!.statusCode == 200 || response.statusCode == 201) {
      final jsonData = jsonDecode(response.body);
      contentModelList.value = ContentModel.fromJson(jsonData);
      totalPages.value = contentModelList.value!.paginationCount!;
    }
    isLoading.value = false;
  }

  @override
  void onInit() {
    super.onInit();
    getDoctorPost();
  }

  String convertDateToformat(String date) {
    DateTime dateTime = DateTime.parse(date);
    DateFormat formatter = DateFormat('dd-MMM-yyyy');
    String formattedDate = formatter.format(dateTime);
    return formattedDate;
  }

  updateLikeOnPost() {}
}
