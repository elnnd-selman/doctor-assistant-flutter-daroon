import 'dart:convert';

import 'package:get/get.dart';
import 'package:hezr/app/modules/doctor/doctor_home/controller/doctor_home_controller.dart';
import 'package:hezr/app/modules/doctor/doctor_profile/model/post_model.dart';
import 'package:hezr/global/constants/app_tokens.dart';
import 'package:hezr/services/api.dart';
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
            Get.find<DoctorHomeController>().userModel.value!.token!,
      },
    );
    if (response!.statusCode == 200 || response.statusCode == 201) {
      final jsonData = jsonDecode(response.body);
      contentModelList.value = ContentModel.fromJson(jsonData);
      totalPages.value = contentModelList.value!.paginationCount!;
      print(contentModelList.value!.data.length);
    }
    isLoading.value = false;
  }

  @override
  void onInit() {
    super.onInit();

    getDoctorPost();
  }

  String convertDateToformat(String date) {
    // Your input date string

    // Parse the input date string to a DateTime object
    DateTime dateTime = DateTime.parse(date);

    // Define the desired format
    DateFormat formatter = DateFormat('dd-MMM-yyyy');

    // Format the DateTime object to the desired string format
    String formattedDate = formatter.format(dateTime);

    // Print the formatted date
    print(formattedDate); // Output: 27-Jul-2024

    return formattedDate;
  }
}
