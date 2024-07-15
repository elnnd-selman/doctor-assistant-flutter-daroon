import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hezr/app/modules/doctor/doctor_home/controller/doctor_home_controller.dart';
import 'package:hezr/global/widgets/toast_message.dart';
import 'package:hezr/services/api.dart';
import 'package:image_picker/image_picker.dart';

class DoctorAddPostController extends GetxController {
  final imagePicker = ImagePicker();

  final _processing = false.obs;
  bool get processing => _processing.value;

  RxList<String> imageList = <String>[].obs;
  RxList<String> videoList = <String>[].obs;

  TextEditingController titleKU = TextEditingController();
  TextEditingController titleEN = TextEditingController();
  TextEditingController titleAR = TextEditingController();

  TextEditingController descKU = TextEditingController();
  TextEditingController descEN = TextEditingController();
  TextEditingController descAR = TextEditingController();

  uploadContent(BuildContext context) async {
    print(Get.find<DoctorHomeController>().userModel.value!.token!);
    print(Get.find<DoctorHomeController>().userModel.value!.user!.id!);
    _processing.value = true;
    final response = await ApiService.uploadContentApi(
      userToken: Get.find<DoctorHomeController>().userModel.value!.token!,
      imageList: imageList,
      videoList: videoList,
      titleKU: titleKU.text,
      titleEN: titleEN.text,
      titleAR: titleAR.text,
      descriptionKU: descKU.text,
      descriptionEN: descEN.text,
      descriptionAR: descAR.text,
    );

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 201 || response.statusCode == 200) {
      showToastMessage(
          message: "Successfully added Content",
          context: context,
          color: const Color(0xff5BA66B),
          icon: Icons.check);
      clearController();
    } else {
      showToastMessage(
          message: response.body,
          context: context,
          color: const Color(0xffEC1C24),
          icon: Icons.close);
    }
    _processing.value = false;
  }

  clearController() {
    titleKU.clear();
    titleEN.clear();
    titleAR.clear();
    descKU.clear();
    descEN.clear();
    descAR.clear();
    imageList.value = [];
    videoList.value = [];
  }

  removeImage(int index) {
    imageList.removeAt(index);
    update();
  }

  removeVideo(int index) {
    videoList.removeAt(index);
    update();
  }

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
        imageList.add(value.path);

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
        imageList.add(value.path);
        update();
      }
    });
  }

  Future pickVideoFromGallery() async {
    imagePicker
        .pickVideo(
      source: ImageSource.gallery,
    )
        .then((value) async {
      if (value != null) {
        videoList.add(value.path);
        update();
      }
    });
  }

  Future pickVideoFromCamera() async {
    imagePicker
        .pickVideo(
      source: ImageSource.camera,
    )
        .then((value) async {
      if (value != null) {
        videoList.add(value.path);
        update();
      }
    });
  }
}
