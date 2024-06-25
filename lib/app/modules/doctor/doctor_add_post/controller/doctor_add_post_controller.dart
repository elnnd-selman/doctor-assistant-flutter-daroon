import 'dart:io';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as path;

class DoctorAddPostController extends GetxController {
  RxBool isNoPhoto = true.obs;
  final imagePicker = ImagePicker();
  late File image;
  String? selectedImageName;
  RxString? selectedimageName = "".obs;

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
        image = File(value.path);

        selectedimageName!.value = value.path;

        isNoPhoto.value = false;
        image = await compress(image: image);
        selectedImageName = path.basename(image.path);
        update();
      } else {
        selectedImageName = '';
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
        image = File(value.path);
        selectedimageName!.value = value.path;
        update();
        isNoPhoto.value = false;
        // image = await compress(image: image);
        selectedImageName = 'captured-image.jpg';
      } else {
        selectedImageName = '';
      }
    });
  }

  static Future<File> compress({
    required File image,
    int quality = 100,
    int percentage = 70,
  }) async {
    final path = await FlutterNativeImage.compressImage(
      image.absolute.path,
      quality: quality,
      percentage: percentage,
    );
    return path;
  }
}
