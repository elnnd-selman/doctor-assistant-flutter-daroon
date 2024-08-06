import 'dart:convert';
import 'package:daroon_doctor/app/modules/doctor/doctor_address/controller/doctor_address_controller.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_address/model/doctor_office_address_model.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_address/model/office_type_model.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_home/controller/doctor_home_controller.dart';
import 'package:daroon_doctor/global/widgets/toast_message.dart';
import 'package:daroon_doctor/services/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditDoctorAddressController extends GetxController {
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController streetNumber = TextEditingController();
  TextEditingController townName = TextEditingController();
  TextEditingController cityName = TextEditingController();
  TextEditingController countryName = TextEditingController();
  RxDouble long = 0.0.obs;
  RxDouble lat = 0.0.obs;

  RxInt slectedOffice = 0.obs;
  final _processing = false.obs;
  bool get processing => _processing.value;
  RxBool isReBuild = false.obs;

  setAddressData(OfficeAddreesModel ofiices) {
    title.text = ofiices.title!;
    description.text = ofiices.description!;
    streetNumber.text = ofiices.address!.street!;
    townName.text = ofiices.address!.town!;
    cityName.text = ofiices.address!.city!;
    countryName.text = ofiices.address!.country!;

    long.value = ofiices.address!.coordinate!.longitude!;
    lat.value = ofiices.address!.coordinate!.latitude!;

    if (ofiices.typeOfOffice == "house") {
      slectedOffice.value = 0;
    } else if (ofiices.typeOfOffice == "building") {
      slectedOffice.value = 1;
    } else if (ofiices.typeOfOffice == "office") {
      slectedOffice.value = 2;
    } else {
      slectedOffice.value = 3;
    }
  }

  Future<void> updateOffice(
      {required BuildContext context,
      required OfficeAddreesModel office}) async {
    try {
      _processing.value = true;
      FocusManager.instance.primaryFocus?.unfocus();

      final response = await ApiService.pustwithOutHeader(
          userToken: {
            'Content-Type': 'application/json',
            "Authorization":
                "Bearer ${Get.find<DoctorHomeController>().userModel.value!.token!}",
          },
          endPoint:
              'https://development-api.daroon.krd/api/office/update-my-office/${office.id}',
          body: {
            "title": title.text,
            "doctorId":
                Get.find<DoctorHomeController>().userModel.value!.user!.id!,
            "description": description.text,
            "typeOfOffice":
                officeTypeList[slectedOffice.value].title.toLowerCase(),
            "daysOpen": office.daysOpen,
            "startTime": office.startTime,
            "endTime": office.endTime,
            "appointmentDuration": office.appointmentDuration,
            "appointmentTimeType": "hour",
            "fee": {
              "feeClinic": office.fee!.feeClinic!,
              "feeMessage": office.fee!.feeMessage!,
              "feeCall": office.fee!.feeCall!,
              "feeVideoCall": office.fee!.feeVideoCall!
            },
            "typeOfCurrency": "usd",
            "phoneNumbers": ["07500132", "075016132"],
            "address": {
              "coordinate": {
                "latitude": "${lat.value}",
                "longitude": "${long.value}",
              },
              "country": countryName.text,
              "city": cityName.text,
              "town": townName.text,
              "street": streetNumber.text
            }
          });

      if (response != null) {
        if (response.statusCode == 201 || response.statusCode == 200) {
          showToastMessage(
              message: "Successfully register.",
              context: context,
              color: const Color(0xff5BA66B),
              icon: Icons.check);
          final jsonData = jsonDecode(response.body)['data'];
          Get.find<DoctorAddressController>()
              .officeAddressModelList
              .removeWhere((item) => item.id == office.id);
          Get.find<DoctorAddressController>()
              .officeAddressModelList
              .add(OfficeAddreesModel.fromJson(jsonData));

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
      _processing.value = false;
      showToastMessage(
          message: "Issue ${e.toString()}",
          context: context,
          color: const Color(0xffEC1C24),
          icon: Icons.close);
    }
  }
}
