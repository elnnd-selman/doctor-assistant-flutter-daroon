import 'dart:convert';
import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_home/controller/doctor_home_controller.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_offers/model/doctor_offer_model.dart';
import 'package:daroon_doctor/global/constants/app_tokens.dart';
import 'package:daroon_doctor/global/widgets/toast_message.dart';
import 'package:daroon_doctor/services/api.dart';
import 'package:flutter/material.dart';
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

  CustomPopupMenuController controller = CustomPopupMenuController();

  List<String> menuList = [
    "Edit",
    "Delete",
  ];

  RxBool isLoading = false.obs;
  final Rxn<DoctorOfferModel> _doctorOfferModel = Rxn();

  RxList<DoctorOffersData> doctorOfferPublishedModel = <DoctorOffersData>[].obs;
  RxList<DoctorOffersData> doctorOfferPendingModel = <DoctorOffersData>[].obs;

  getDoctorOfersData() async {
    isLoading.value = true;
    doctorOfferPublishedModel.value = [];
    doctorOfferPendingModel.value = [];
    try {
      final response = await ApiService.getwithUserToken(
        endPoint: '${AppTokens.apiURl}/doctors/offers/my-offers',
        userToken: {
          "Authorization":
              "Bearer ${Get.find<DoctorHomeController>().userModel.value!.token!}",
        },
      );

      if (response!.statusCode == 200 || response.statusCode == 201) {
        final jsonData = jsonDecode(response.body);

        _doctorOfferModel.value = DoctorOfferModel.fromJson(jsonData);
        if (_doctorOfferModel.value != null) {
          if (_doctorOfferModel.value!.data.isNotEmpty) {
            for (int i = 0; i < _doctorOfferModel.value!.data.length; i++) {
              if (_doctorOfferModel.value!.data[i].status == "pending") {
                doctorOfferPendingModel.add(_doctorOfferModel.value!.data[i]);
              } else {
                doctorOfferPublishedModel.add(_doctorOfferModel.value!.data[i]);
              }
            }
          }
        }
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
    if (_selectedTab.value == 0) {
      if (doctorOfferPublishedModel.isNotEmpty) {
        offerSearchList.value = doctorOfferPublishedModel.where((item) {
          return item.titleEn!.toLowerCase().contains(query.toLowerCase());
        }).toList();
      }
    } else {
      if (doctorOfferPendingModel.isNotEmpty) {
        offerSearchList.value = doctorOfferPendingModel.where((item) {
          return item.titleEn!.toLowerCase().contains(query.toLowerCase());
        }).toList();
      }
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
    String formattedMonth = DateFormat('MMMM').format(dateTime);

    return '$formattedDate $formattedMonth';
  }

  RxBool deleteLoader = false.obs;
  deleteOffer({
    required DoctorOffersData data,
    required BuildContext context,
  }) async {
    deleteLoader.value = true;
    try {
      final response = await ApiService.deleteWithHeader(
        userToken: {
          'Content-Type': 'application/json',
          "Authorization":
              "Bearer ${Get.find<DoctorHomeController>().userModel.value!.token!}",
        },
        endPoint: '${AppTokens.apiURl}/doctors/offers/${data.id}/delete',
        body: {},
      );

      if (response != null) {
        if (response.statusCode == 200 || response.statusCode == 201) {
          printInfo(info: "Suucessfull Delete Assistant ${response.body}");

          if (selectedTab == 0) {
            doctorOfferPublishedModel.removeWhere((item) => item.id == data.id);
          } else {
            doctorOfferPendingModel.removeWhere((item) => item.id == data.id);
          }

          Get.back();
          showToastMessage(
              message: "Suucessfull Delete Offer",
              context: context,
              color: const Color(0xff5BA66B),
              icon: Icons.check);
        } else {
          printInfo(info: "Error While Deleting Offer ${response.body}");
          showToastMessage(
              message: response.body,
              context: context,
              color: const Color(0xffEC1C24),
              icon: Icons.close);
        }
      }
      deleteLoader.value = false;
    } catch (e) {
      deleteLoader.value = false;
      printInfo(info: e.toString());
    }
  }
}
