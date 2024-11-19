import 'dart:async';
import 'dart:convert';
import 'package:daroon_doctor/app/modules/doctor/doctor_home/controller/doctor_home_controller.dart';
import 'package:daroon_doctor/global/widgets/toast_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:daroon_doctor/app/controllers/local_storage_controller.dart';
import 'package:daroon_doctor/app/model/user_model.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_address/model/doctor_office_address_model.dart';
import 'package:daroon_doctor/global/constants/app_tokens.dart';
import 'package:daroon_doctor/services/api.dart';
import 'dart:ui' as ui;

class DoctorAddressController extends GetxController {
  RxBool isLoading = false.obs;
  RxList<OfficeAddreesModel> officeAddressModelList = RxList();
  CameraPosition kGooglePlex = const CameraPosition(
    target: LatLng(51.174179, 6.610550),
    zoom: 12.4746,
  );
  Rxn<UserModel> userModel = Rxn();

  final Completer<GoogleMapController> completer =
      Completer<GoogleMapController>();
  // CustomPopupMenuController customPopupMenuController =
  //     CustomPopupMenuController();

  RxList<String> menuList = [
    "Delete",
  ].obs;
  RxList<Marker> markers = <Marker>[].obs;
  getDoctorOfficeAddress() async {
    isLoading.value = true;
    officeAddressModelList.value = [];
    final Uint8List markerIcon =
        await getBytesFromAsset('assets/icons_png/location_icon.png', 80);

    final response = await ApiService.getwithUserToken(
      endPoint: "${AppTokens.apiURl}/doctors/offices/my-offices",
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
            // ignore: deprecated_member_use
            icon: BitmapDescriptor.fromBytes(markerIcon),
            markerId: MarkerId(officeAddressModelList[i].id!),
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
          .sort((a, b) => b.updatedAt!.compareTo(a.updatedAt!));
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

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  RxBool isDeleting = false.obs;
  deleteOffice({
    required OfficeAddreesModel data,
    required BuildContext context,
    required bool isMainPage,
  }) async {
    isDeleting.value = true;
    try {
      final response = await ApiService.deleteWithHeader(
        userToken: {
          'Content-Type': 'application/json',
          "Authorization":
              "Bearer ${Get.find<DoctorHomeController>().userModel.value!.token!}",
        },
        endPoint: '${AppTokens.apiURl}/doctors/offices/${data.id}/delete',
        body: {},
      );

      if (response != null) {
        if (response.statusCode == 200 || response.statusCode == 201) {
          printInfo(info: "Suucessfull Delete Office Address ${response.body}");

          officeAddressModelList.removeWhere((item) => item.id == data.id);
          markers.removeWhere((item) => item.markerId.value == data.id);

          if (!isMainPage) {
            Get.back();
          }
          showToastMessage(
              message: "You deleted an address successfully.",
              context: context,
              color: const Color(0xff5BA66B),
              icon: Icons.check);
        } else {
          printInfo(info: "Error While Deleting Office ${response.body}");
          showToastMessage(
              message: response.body,
              context: context,
              color: const Color(0xffEC1C24),
              icon: Icons.close);
        }
      }
      isDeleting.value = false;
    } catch (e) {
      isDeleting.value = false;
      printInfo(info: e.toString());
    }
  }
}
