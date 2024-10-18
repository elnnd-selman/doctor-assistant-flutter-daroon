import 'package:daroon_doctor/app/modules/doctor/doctor_profile/controller/doctor_edit_profile_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:daroon_doctor/global/constants/app_colors.dart';
import 'package:daroon_doctor/global/utils/app_text_style.dart';

Future<void> updateProfilePhoto(BuildContext context) async {
  final controller = Get.find<DoctorEditProfileController>();
  showCupertinoModalPopup(
    context: context,
    builder: (context) {
      return CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            onPressed: () {
              controller.getGalleryImage(context);
              Get.back();
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
              controller.getCameraImage(context);
              Get.back();
            },
            child: Text('Camera Image',
                style: AppTextStyles.medium.copyWith(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
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
                color: AppColors.blackBGColor,
              )),
        ),
      );
    },
  );
}
