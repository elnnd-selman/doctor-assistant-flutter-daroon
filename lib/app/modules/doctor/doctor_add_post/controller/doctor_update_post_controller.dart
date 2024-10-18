import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_home/controller/doctor_home_controller.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_profile/controller/doctor_profile_controller.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_profile/model/post_model.dart';
import 'package:daroon_doctor/global/widgets/toast_message.dart';
import 'package:daroon_doctor/services/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class DoctorUpdatePostController extends GetxController {
  final imagePicker = ImagePicker();
  RxList<String> imageList = <String>[].obs;
  RxList<String> videoList = <String>[].obs;

  final _processing = false.obs;
  bool get processing => _processing.value;
  TextEditingController titleKU = TextEditingController();
  TextEditingController titleEN = TextEditingController();
  TextEditingController titleAR = TextEditingController();

  TextEditingController descKU = TextEditingController();
  TextEditingController descEN = TextEditingController();
  TextEditingController descAR = TextEditingController();
  RxString contentID = ''.obs;
  setEditPostData(ContentData contentData) async {
    _processing.value = true;
    contentID.value = contentData.id!;
    titleEN.text = contentData.titleEn!;
    titleKU.text = contentData.titleKu!;
    titleAR.text = contentData.titleAr!;
    descAR.text = contentData.contentAr!;
    descEN.text = contentData.contentEn!;
    descKU.text = contentData.contentKu!;

    if (contentData.images.isNotEmpty) {
      for (int i = 0; i < contentData.images.length; i++) {
        final downUrl = await downloadImage(contentData.images[i]);
        imageList.add(downUrl.path);
      }
    }

    if (contentData.videos.isNotEmpty) {
      for (int i = 0; i < contentData.videos.length; i++) {
        final downUrl = await downloadVideo(contentData.videos[i]);
        videoList.add(downUrl.path);
      }
    }
    _processing.value = false;
  }

  Future<File> downloadImage(String url) async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Directory directory = await getApplicationDocumentsDirectory();
      final File file =
          File('${directory.path}/${Timestamp.now().toString()}.png');
      await file.writeAsBytes(response.bodyBytes);
      return file;
    } else {
      throw Exception('Failed to load image');
    }
  }

  Future<File> downloadVideo(String url) async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Directory directory = await getApplicationDocumentsDirectory();
      final File file =
          File('${directory.path}/${Timestamp.now().toString()}.mp4');
      await file.writeAsBytes(response.bodyBytes);
      return file;
    } else {
      throw Exception('Failed to load video');
    }
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

  updateContantPost(BuildContext context) async {
    _processing.value = true;
    final response = await ApiService.upadteContentApi(
      contentID: contentID.value,
      userToken:
          "Bearer ${Get.find<DoctorHomeController>().userModel.value!.token!}",
      imageList: imageList,
      videoList: videoList,
      titleKU: titleKU.text,
      titleEN: titleEN.text,
      titleAR: titleAR.text,
      descriptionKU: descKU.text,
      descriptionEN: descEN.text,
      descriptionAR: descAR.text,
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      Get.find<DoctorProfileController>().getDoctorPost();
      clearController();
      Get.back();
      showToastMessage(
          message: "Successfully updated Content",
          context: context,
          color: const Color(0xff5BA66B),
          icon: Icons.check);

      _processing.value = false;
    } else {
      _processing.value = false;
    }
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

  checkValidation() {}
}
