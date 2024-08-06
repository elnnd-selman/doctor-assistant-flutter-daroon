import 'dart:convert';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:daroon_doctor/app/controllers/local_storage_controller.dart';
import 'package:daroon_doctor/app/model/user_model.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_address/model/doctor_office_address_model.dart';
import 'package:daroon_doctor/global/constants/app_tokens.dart';
import 'package:daroon_doctor/services/api.dart';

class DoctorAddressController extends GetxController {
  RxBool isLoading = false.obs;
  RxList<OfficeAddreesModel> officeAddressModelList = RxList();
  CameraPosition kGooglePlex = const CameraPosition(
    target: LatLng(51.174179, 6.610550),
    zoom: 12.4746,
  );
  Rxn<UserModel> userModel = Rxn();

  List<Marker> markers = [];
  getDoctorOfficeAddress() async {
    isLoading.value = true;

    final response = await ApiService.getwithUserToken(
      endPoint: "${AppTokens.apiURl}/office/my-offices",
      userToken: {
        "Authorization": "Bearer ${userModel.value!.token!}",
      },
    );
    if (response!.statusCode == 200 || response.statusCode == 201) {
      List<dynamic> jsonResponse = jsonDecode(response.body)['data'];
      officeAddressModelList.value = jsonResponse
          .map((data) => OfficeAddreesModel.fromJson(data))
          .toList();

      for (int i = 0; i < officeAddressModelList.length; i++) {
        if (i == 0) {
          kGooglePlex = CameraPosition(
            target: LatLng(
                officeAddressModelList[i].address!.coordinate!.latitude!,
                officeAddressModelList[i].address!.coordinate!.longitude!),
            zoom: 12.4746,
          );
        }
        markers.add(
          Marker(
            markerId: MarkerId('marker${i + 1}'),
            position: LatLng(
                officeAddressModelList[i].address!.coordinate!.latitude!,
                officeAddressModelList[i].address!.coordinate!.longitude!),
            infoWindow: InfoWindow(
                title: officeAddressModelList[i].title,
                snippet: officeAddressModelList[i].description),
          ),
        );
      }
      officeAddressModelList
          .sort((a, b) => a.updatedAt!.compareTo(b.updatedAt!));
      isLoading.value = false;
    } else {
      isLoading.value = false;
    }
  }

  @override
  Future<void> onInit() async {
    super.onInit();

    userModel.value = await Get.find<LocalStorageController>()
        .daroonBox!
        .get("userModel", defaultValue: UserModel);
    await getDoctorOfficeAddress();
  }
}
