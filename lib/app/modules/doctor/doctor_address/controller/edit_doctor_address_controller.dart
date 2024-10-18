import 'dart:convert';

import 'package:daroon_doctor/app/modules/doctor/doctor_address/controller/doctor_address_controller.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_address/model/doctor_office_address_model.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_address/model/office_type_model.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_home/controller/doctor_home_controller.dart';
import 'package:daroon_doctor/global/constants/app_colors.dart';
import 'package:daroon_doctor/global/constants/app_tokens.dart';
import 'package:daroon_doctor/global/widgets/custom_dialog_box.dart';
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
  // TextEditingController countryName = TextEditingController()
  RxDouble long = 0.0.obs;
  RxDouble lat = 0.0.obs;

  RxString countryID = ''.obs;
  Rxn<Country> currentCountryModel = Rxn();
  RxString currencyID = ''.obs;
  Rxn<TypeOfCurrency> currentCurrencyModel = Rxn();

  ///
  RxString officeTypeID = ''.obs;
  Rxn<TypeOfOffice> currentOfficeTypeModel = Rxn();

  RxInt slectedOffice = 0.obs;
  final _processing = false.obs;
  bool get processing => _processing.value;
  RxBool isReBuild = false.obs;

  setAddressData(OfficeAddreesModel ofiices) async {
    _processing.value = true;
    title.text = ofiices.title!;
    description.text = ofiices.description!;
    streetNumber.text = ofiices.address!.street!;
    townName.text = ofiices.address!.town!;
    cityName.text = ofiices.address!.city!;
    // countryName.text = ofiices.address!.country!;

    long.value = ofiices.address!.coordinate!.longitude!;
    lat.value = ofiices.address!.coordinate!.latitude!;
    await getAllData(ofiices);

    // if (ofiices.typeOfOffice == "house") {
    //   slectedOffice.value = 0;
    // } else if (ofiices.typeOfOffice == "building") {
    //   slectedOffice.value = 1;
    // } else if (ofiices.typeOfOffice == "office") {
    //   slectedOffice.value = 2;
    // } else {
    //   slectedOffice.value = 3;
    // }
  }

  Future<void> updateOffice(
      {required BuildContext context,
      required OfficeAddreesModel office}) async {
    try {
      _processing.value = true;
      FocusManager.instance.primaryFocus?.unfocus();

      final response = await ApiService.putWithHeader(
          userToken: {
            'Content-Type': 'application/json',
            "Authorization":
                "Bearer ${Get.find<DoctorHomeController>().userModel.value!.token!}",
          },
          endPoint: '${AppTokens.apiURl}/office/${office.id}/update',
          body: {
            "title": title.text,
            "doctorId":
                Get.find<DoctorHomeController>().userModel.value!.user!.id!,
            "description": description.text,
            "types-of-offices":
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
            "typeOfCurrency": currencyID.value,
            "phoneNumbers": ["07500132", "075016132"],
            "address": {
              "coordinate": {
                "latitude": "${lat.value}",
                "longitude": "${long.value}",
              },
              "country": countryID.value,
              "city": cityName.text,
              "town": townName.text,
              "street": streetNumber.text,
              "typeOfOffice": officeTypeID.value,
            }
          });

      if (response != null) {
        if (response.statusCode == 201 || response.statusCode == 200) {
          showToastMessage(
              message: "Successfully Updated.",
              context: context,
              color: const Color(0xff5BA66B),
              icon: Icons.check);
          // final jsonData = jsonDecode(response.body)['data'];
          Get.find<DoctorAddressController>().getDoctorOfficeAddress();
          // print("Data");
          // print(jsonData);
          // Get.find<DoctorAddressController>()
          //     .officeAddressModelList
          //     .removeWhere((item) => item.id == office.id);
          // print("Addin");
          // Get.find<DoctorAddressController>()
          //     .officeAddressModelList
          //     .add(OfficeAddreesModel.fromJson(jsonData));
          // print(Get.find<DoctorAddressController>()
          //     .officeAddressModelList
          //     .length);
          // print("Data");
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

  RxList<Country> countryModelList = RxList();

  getOfficeCountry() async {
    final response = await ApiService.getwithUserToken(
      endPoint: "${AppTokens.apiURl}/users/country",
      userToken: {
        "Authorization":
            "Bearer ${Get.find<DoctorHomeController>().userModel.value!.token!}",
      },
    );
    if (response!.statusCode == 200 || response.statusCode == 201) {
      List<dynamic> jsonResponse = jsonDecode(response.body)['data'];
      countryModelList.value =
          jsonResponse.map((data) => Country.fromJson(data)).toList();
    }
  }

  RxList<TypeOfCurrency> currencyModelList = RxList();
  getOfficeCurrency() async {
    final response = await ApiService.getwithUserToken(
      endPoint: "${AppTokens.apiURl}/users/type-of-currency",
      userToken: {
        "Authorization":
            "Bearer ${Get.find<DoctorHomeController>().userModel.value!.token!}",
      },
    );
    if (response!.statusCode == 200 || response.statusCode == 201) {
      List<dynamic> jsonResponse = jsonDecode(response.body)['data'];
      currencyModelList.value =
          jsonResponse.map((data) => TypeOfCurrency.fromJson(data)).toList();
    }
  }

  RxList<TypeOfOffice> officeModelList = RxList();

  getTypeOfOffice() async {
    final response = await ApiService.getwithUserToken(
      endPoint: "${AppTokens.apiURl}/users/type-of-offices",
      userToken: {
        "Authorization":
            "Bearer ${Get.find<DoctorHomeController>().userModel.value!.token!}",
      },
    );
    if (response!.statusCode == 200 || response.statusCode == 201) {
      List<dynamic> jsonResponse = jsonDecode(response.body)['data'];
      officeModelList.value =
          jsonResponse.map((data) => TypeOfOffice.fromJson(data)).toList();
    }
  }

  getAllData(OfficeAddreesModel data) async {
    _processing.value = true;
    await getOfficeCountry();
    await getOfficeCurrency();
    await getTypeOfOffice();

    if (countryModelList.isNotEmpty) {
      currentCountryModel.value = countryModelList.firstWhere(
        (val) => val.id == data.address!.country!.id!,
      );
    }
    countryID.value = currentCountryModel.value!.id!;

    if (currencyModelList.isNotEmpty) {
      currentCurrencyModel.value = currencyModelList.firstWhere(
        (val) => val.id == data.typeOfCurrency!.id!,
      );
    }
    currencyID.value = currentCurrencyModel.value!.id!;
    if (officeModelList.isNotEmpty) {
      currentOfficeTypeModel.value = officeModelList.firstWhere(
        (val) => val.id == data.address!.typeOfOffice!.id!,
      );
    }

    officeTypeID.value = currentOfficeTypeModel.value!.id!;

    _processing.value = false;
  }

  checkValition(
      BuildContext context, OfficeAddreesModel data, bool showDialogBox) {
    if (title.text.isEmpty ||
        streetNumber.text.isEmpty ||
        townName.text.isEmpty ||
        cityName.text.isEmpty ||
        description.text.isEmpty ||
        long.value == 0.0 ||
        lat.value == 0.0 ||
        countryID.value == '' ||
        currencyID.value == '' ||
        officeTypeID.value == '') {
      if (title.text.isEmpty) {
        showToastMessage(
            message: "Enter Title",
            context: context,
            color: const Color(0xffEC1C24),
            icon: Icons.close);
        return;
      } else if (streetNumber.text.isEmpty) {
        showToastMessage(
            message: "Enter Street Number",
            context: context,
            color: const Color(0xffEC1C24),
            icon: Icons.close);
        return;
      } else if (townName.text.isEmpty) {
        showToastMessage(
            message: "Enter Town Name",
            context: context,
            color: const Color(0xffEC1C24),
            icon: Icons.close);
        return;
      } else if (cityName.text.isEmpty) {
        showToastMessage(
            message: "Enter City Name",
            context: context,
            color: const Color(0xffEC1C24),
            icon: Icons.close);
        return;
      } else if (description.text.isEmpty) {
        showToastMessage(
            message: "Enter Description",
            context: context,
            color: const Color(0xffEC1C24),
            icon: Icons.close);
        return;
      } else if (long.value == 0.0 || lat.value == 0.0) {
        showToastMessage(
            message: "Select Address",
            context: context,
            color: const Color(0xffEC1C24),
            icon: Icons.close);
        return;
      } else if (countryID.value == '') {
        showToastMessage(
            message: "Select Country",
            context: context,
            color: const Color(0xffEC1C24),
            icon: Icons.close);
        return;
      } else if (currencyID.value == '') {
        showToastMessage(
            message: "Select Currency",
            context: context,
            color: const Color(0xffEC1C24),
            icon: Icons.close);
        return;
      } else if (officeTypeID.value == '') {
        showToastMessage(
            message: "Select Office Type",
            context: context,
            color: const Color(0xffEC1C24),
            icon: Icons.close);
        return;
      }
    } else {
      FocusManager.instance.primaryFocus?.unfocus();

      if (showDialogBox) {
        Get.dialog(
          CustomDialogBox(
            title: 'Save change',
            confirmButtonText: 'Save',
            onPressedCancel: () {
              Get.back();
            },
            onPressedConfirm: () {
              Get.back();
              updateOffice(context: context, office: data);
            },
            subTitle: 'Are you sure you want to\ndiscard the change?',
          ),
          barrierColor: AppColors.blackBGColor.withOpacity(0.5),
        );
      } else {
        Get.back();
        updateOffice(context: context, office: data);
      }
    }
  }
}
