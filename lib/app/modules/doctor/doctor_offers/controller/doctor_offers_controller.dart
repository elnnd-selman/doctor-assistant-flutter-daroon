import 'dart:convert';
import 'package:daroon_doctor/app/modules/doctor/doctor_home/controller/doctor_home_controller.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_offers/model/doctor_offer_model.dart';
import 'package:daroon_doctor/global/constants/app_tokens.dart';
import 'package:daroon_doctor/services/api.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DoctorOffersController extends GetxController {
  RxBool isAppBarOpen = false.obs;
  // RxInt isSelected = 0.obs;

  final _selectedTab = 0.obs;
  int get selectedTab => _selectedTab.value;

  void selectTab(int value) async {
    _selectedTab.value = value;
  }

  RxBool isLoading = false.obs;
  Rxn<DoctorOfferModel> doctorOfferModel = Rxn();

  getDoctorOfersData() async {
    isLoading.value = true;
    try {
      final response = await ApiService.getwithUserToken(
        endPoint: '${AppTokens.apiURl}/offers/my-offers',
        userToken: {
          "Authorization":
              "Bearer ${Get.find<DoctorHomeController>().userModel.value!.token!}",
        },
      );

      if (response!.statusCode == 200 || response.statusCode == 201) {
        final jsonData = jsonDecode(response.body);

        doctorOfferModel.value = DoctorOfferModel.fromJson(jsonData);
      } else {
        printError(info: response.body);
      }
      isLoading.value = false;
    } catch (e) {
      printError(info: e.toString());
      isLoading.value = false;
    }
  }

  RxBool isSearch = false.obs;
  RxList<DoctorOffersData> offerSearchList = <DoctorOffersData>[].obs;

  searchOffer(String query) {
    offerSearchList.value = [];
    if (doctorOfferModel.value!.data.isNotEmpty) {
      offerSearchList.value = doctorOfferModel.value!.data.where((item) {
        return item.titleEn!.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
  }

  @override
  void onInit() {
    getDoctorOfersData();
    super.onInit();
  }

  String formatDate(String date) {
    DateTime dateTime = DateTime.parse(date);

    String formattedDate = DateFormat('dd/MM/yyyy').format(dateTime);
    String formattedMonth =
        DateFormat('MMMM').format(dateTime);

    return '$formattedDate $formattedMonth';
  }
}
