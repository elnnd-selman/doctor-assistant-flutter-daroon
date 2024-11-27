import 'dart:convert';
import 'package:daroon_doctor/app/modules/doctor/doctor_home/controller/doctor_home_controller.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_offers/controller/doctor_offers_controller.dart';
import 'package:daroon_doctor/app/routes/app_routes.dart';
import 'package:daroon_doctor/global/constants/app_tokens.dart';
import 'package:daroon_doctor/global/utils/json_message_extension.dart';
import 'package:daroon_doctor/global/widgets/toast_message.dart';
import 'package:daroon_doctor/services/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class AddOfferController extends GetxController {
  RxInt selectedIndex = RxInt(-1);
  RxString selectedAddress = "".obs;
  RxString selectedAddressID = "".obs;
  final imagePicker = ImagePicker();

  RxString imageUrl = ''.obs;

  Rxn<DateTime> startTime = Rxn(null);
  Rxn<DateTime> endTime = Rxn(null);

  final _processing = false.obs;
  bool get processing => _processing.value;

  final TextEditingController titleKu = TextEditingController();
  final TextEditingController titleEn = TextEditingController();
  final TextEditingController titleAR = TextEditingController();
  final TextEditingController currentPrice = TextEditingController();
  final TextEditingController discountPrice = TextEditingController();
  final TextEditingController descriptionKu = TextEditingController();
  final TextEditingController descriptionEN = TextEditingController();
  final TextEditingController descriptionAR = TextEditingController();

  Future getGalleryImage() async {
    imagePicker
        .pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
      maxHeight: 800,
      maxWidth: 800,
    )
        .then((value) async {
      if (value != null) {
        imageUrl.value = value.path;

        update();
      }
    });
  }

  Future getCameraImage() async {
    imagePicker
        .pickImage(
      source: ImageSource.camera,
      imageQuality: 80,
      maxHeight: 800,
      maxWidth: 800,
    )
        .then((value) async {
      if (value != null) {
        imageUrl.value = value.path;
        update();
      }
    });
  }

  String formatDate(DateTime date) {
    DateFormat formatter = DateFormat('dd-MM-yy – kk:mm');
    String formattedDate = formatter.format(date);
    return formattedDate;
  }

  checkValidation(BuildContext context) {
    FocusManager.instance.primaryFocus?.unfocus();
    if (titleKu.text.isEmpty) {
      showToastMessage(
          message: "Enter Title-Ku",
          context: context,
          color: const Color(0xffEC1C24),
          icon: Icons.close);
      return;
    } else if (titleEn.text.isEmpty) {
      showToastMessage(
          message: "Enter Title-En",
          context: context,
          color: const Color(0xffEC1C24),
          icon: Icons.close);
      return;
    }
    if (titleAR.text.isEmpty) {
      showToastMessage(
          message: "Enter Title-Ar",
          context: context,
          color: const Color(0xffEC1C24),
          icon: Icons.close);
      return;
    } else if (currentPrice.text.isEmpty) {
      showToastMessage(
          message: "Enter Current Price",
          context: context,
          color: const Color(0xffEC1C24),
          icon: Icons.close);
      return;
    } else if (discountPrice.text.isEmpty) {
      showToastMessage(
          message: "Enter Discount Price",
          context: context,
          color: const Color(0xffEC1C24),
          icon: Icons.close);
      return;
    } else if (descriptionKu.text.isEmpty) {
      showToastMessage(
          message: "Enter Description-Ku",
          context: context,
          color: const Color(0xffEC1C24),
          icon: Icons.close);
    } else if (descriptionEN.text.isEmpty) {
      showToastMessage(
          message: "Enter Description-En",
          context: context,
          color: const Color(0xffEC1C24),
          icon: Icons.close);
    } else if (descriptionAR.text.isEmpty) {
      showToastMessage(
          message: "Enter Description-Ar",
          context: context,
          color: const Color(0xffEC1C24),
          icon: Icons.close);
    } else if (startTime.value == null) {
      showToastMessage(
          message: "Select Start Date",
          context: context,
          color: const Color(0xffEC1C24),
          icon: Icons.close);
    } else if (endTime.value == null) {
      showToastMessage(
          message: "Select End Date",
          context: context,
          color: const Color(0xffEC1C24),
          icon: Icons.close);
    } else if (imageUrl.value == '') {
      showToastMessage(
          message: "Choose Image ",
          context: context,
          color: const Color(0xffEC1C24),
          icon: Icons.close);
    } else {
      Get.toNamed(Routes.addOfferAddress);
    }
  }

  registerDoctorOffer(BuildContext context) async {
    _processing.value = true;

    final imageResponse = await ApiService.uploadImageInDataBase(
      url: '${AppTokens.apiURl}/contents/upload-image',
      headers: {
        "Content-type": "multipart/form-data",
        "Authorization":
            "Bearer ${Get.find<DoctorHomeController>().userModel.value!.token!}",
      },
      imageURL: imageUrl.value,
      fieldName: 'image',
    );

    if (imageResponse.statusCode == 200 || imageResponse.statusCode == 201) {
      final imageJsonData = jsonDecode(imageResponse.body);

      final jsonData = {
        "title_ku": titleKu.text,
        "title_ar": titleAR.text,
        "title_en": titleEn.text,
        "description_ku": descriptionKu.text,
        "description_ar": descriptionAR.text,
        "description_en": descriptionEN.text,
        "discountPercentage": 15,
        "currentPrice": 100,
        "currency": "usd",
        "image": imageJsonData['imageKey'],
        "office": selectedAddressID.value,
        "startTime": startTime.value.toString(),
        "endTime": endTime.value.toString(),
      };
      final response = await ApiService.postWithHeader(
        userToken: {
          "Content-Type": 'application/json',
          "Authorization":
              "Bearer ${Get.find<DoctorHomeController>().userModel.value!.token!}",
        },
        endPoint: '${AppTokens.apiURl}/doctors/offers',
        body: jsonData,
      );
      if (response != null) {
        if (response.statusCode == 201 || response.statusCode == 200) {
          showToastMessage(
              message: "Successfully Created Offer",
              // ignore: use_build_context_synchronously
              context: context,
              color: const Color(0xff5BA66B),
              icon: Icons.check);
          _processing.value = false;
          Get.find<DoctorOffersController>().getDoctorOfersData();
          Get.offNamed(Routes.addOfferSuccessfully, arguments: [
            "Great! you add new offer\nsuccessfully.",
          ]);
        } else {
          _processing.value = false;
          showToastMessage(
              message: response.body.extractErrorMessage(),
              // ignore: use_build_context_synchronously
              context: context,
              color: const Color(0xffEC1C24),
              icon: Icons.close);
        }
      } else {
        _processing.value = false;
        printError(info: imageResponse.body);
        showToastMessage(
            message: imageResponse.body,
            // ignore: use_build_context_synchronously
            context: context,
            color: const Color(0xffEC1C24),
            icon: Icons.close);
      }
    }
  }
}
