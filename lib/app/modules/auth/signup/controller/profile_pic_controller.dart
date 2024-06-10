import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:get/get.dart';
import 'package:hezr/global/constants/app_colors.dart';
import 'package:hezr/global/utils/app_text_style.dart';

// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as path;

import 'package:image_picker/image_picker.dart';

class ProfilePicController extends GetxController {
  RxBool isNoPhoto = true.obs;
  final imagePicker = ImagePicker();
  late File image;
  String? selectedImageName;
  RxString? selectedimageName = "".obs;

  Future<void> addPhoto(BuildContext context) async {
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return CupertinoActionSheet(
          actions: [
            CupertinoActionSheetAction(
              onPressed: () {
                _getGalleryImage();
                Navigator.pop(context);
              },
              child: Text('Gallery Image',
                  style: AppTextStyles.medium.copyWith(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    // fontFamily: ksecondaryFontFamily,
                    color: AppColors.blackBGColor,
                  )),
            ),
            CupertinoActionSheetAction(
              onPressed: () {
                _getCameraImage();
                Navigator.pop(context);
              },
              child: Text('Camera Image',
                  style: AppTextStyles.medium.copyWith(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    // fontFamily: ksecondaryFontFamily,
                    color: AppColors.blackBGColor,
                  )),
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel',
                style: AppTextStyles.medium.copyWith(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  // fontFamily: ksecondaryFontFamily,
                  color: AppColors.blackBGColor,
                )),
          ),
        );
      },
    );
  }

  Future _getGalleryImage() async {
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

  Future _getCameraImage() async {
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
