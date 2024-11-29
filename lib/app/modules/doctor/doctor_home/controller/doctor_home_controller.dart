import 'dart:convert';

import 'package:daroon_doctor/app/modules/doctor/doctor_appointment/model/doctor_appointmet_model.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_home/model/public_ads_model.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_offers/model/doctor_offer_model.dart';
import 'package:daroon_doctor/app/routes/app_routes.dart';
import 'package:daroon_doctor/global/constants/app_tokens.dart';
import 'package:daroon_doctor/services/api.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:daroon_doctor/app/controllers/local_storage_controller.dart';
import 'package:daroon_doctor/app/model/user_model.dart';
import 'package:daroon_doctor/global/constants/app_colors.dart';

class DoctorHomeController extends GetxController {
  RxInt isSelected = 0.obs;

  final _selectedTab = 0.obs;
  int get selectedTab => _selectedTab.value;

  void selectTab(int value) async {
    _selectedTab.value = value;
  }

  List<Color> gradientColors = [
    AppColors.primaryColor,
    AppColors.primaryColor,
  ];

  Rxn<UserModel> userModel = Rxn();

  TextEditingController searchTextField = TextEditingController();
  @override
  Future<void> onInit() async {
    super.onInit();

    // Get.find<LocalStorageController>().daroonBox!.delete("isLogin");

    userModel.value = await Get.find<LocalStorageController>()
        .daroonBox!
        .get("userModel", defaultValue: UserModel);
    if (kDebugMode) {
      print(userModel.value!.token!);
      print(userModel.value!.user!.id!);
    }
    getDoctorAppointments();
    getDoctorOfersData();
    _getCurrentPosition();
    getPublicAds();
  }

  signOutUser() {
    Get.find<LocalStorageController>().daroonBox!.delete("isLogin");
    Get.offAllNamed(Routes.login);
  }

  RxBool isLoading = false.obs;
  RxList<AppointmentModel> upcomingAppointmentList = RxList();

  getDoctorAppointments() async {
    isLoading.value = true;

    final response = await ApiService.getwithUserToken(
      endPoint: "${AppTokens.apiURl}/doctors/appointments?status=upcoming",
      userToken: {
        "Authorization": "Bearer ${userModel.value!.token!}",
      },
    );
    if (response!.statusCode == 200 || response.statusCode == 201) {
      List<dynamic> jsonResponse = jsonDecode(response.body)['data'];
      upcomingAppointmentList.value =
          jsonResponse.map((data) => AppointmentModel.fromJson(data)).toList();

      upcomingAppointmentList
          .sort((a, b) => a.updatedAt!.compareTo(b.updatedAt!));

      isLoading.value = false;
    } else {
      isLoading.value = false;
      final jsonData = jsonDecode(response.body);
      if (jsonData["message"] == 'unauthorized') {
        signOutUser();
      }
    }
  }

  RxBool processing = false.obs;
  final Rxn<DoctorOfferModel> _doctorOfferModel = Rxn();

  RxList<DoctorOffersData> doctorOfferPublishedModel = <DoctorOffersData>[].obs;
  RxList<DoctorOffersData> doctorOfferPendingModel = <DoctorOffersData>[].obs;

  getDoctorOfersData() async {
    processing.value = true;
    doctorOfferPublishedModel.value = [];
    doctorOfferPendingModel.value = [];
    try {
      final response = await ApiService.getwithUserToken(
        endPoint:
            '${AppTokens.apiURl}/doctors/offers/my-offers?sort=booked_number',
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
      doctorOfferPublishedModel
          .sort((a, b) => a.bookedNumber!.compareTo(b.bookedNumber!));
      processing.value = false;
    } catch (e) {
      printError(info: e.toString());
      isLoading.value = false;
    }
  }

  RxString userLocation = ''.obs;
  Future<void> _getCurrentPosition() async {
    final position = await _determinePosition();
    userLocation.value =
        await getAddressFromCoordinates(position.latitude, position.longitude);
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we   cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<String> getAddressFromCoordinates(
      double latitude, double longitude) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        return '${place.locality}, ${place.country}';
      } else {
        return 'Address not found';
      }
    } catch (e) {
      return 'Error getting address: $e';
    }
  }

  RxList<PublicAdsModel> publicADSList = <PublicAdsModel>[].obs;
  RxBool isAdsLoading = false.obs;
  getPublicAds() async {
    try {
      publicADSList.value = [];
      isAdsLoading.value = true;
      final response = await ApiService.getwithUserToken(
        endPoint: "${AppTokens.apiURl}/ads",
        userToken: {
          "Authorization":
              "Bearer ${Get.find<DoctorHomeController>().userModel.value!.token!}",
        },
      );
      if (response!.statusCode == 200 || response.statusCode == 201) {
        List<dynamic> jsonResponse = jsonDecode(response.body)['data'];
        publicADSList.value =
            jsonResponse.map((data) => PublicAdsModel.fromJson(data)).toList();
      }
      isAdsLoading.value = false;
    } catch (e) {
      isAdsLoading.value = false;
      printInfo(info: e.toString());
    }
  }
}
