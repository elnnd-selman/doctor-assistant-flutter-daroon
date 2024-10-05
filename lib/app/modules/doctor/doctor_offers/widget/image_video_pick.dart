import 'package:daroon_doctor/app/modules/doctor/doctor_offers/controller/add_offer_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:daroon_doctor/global/constants/app_colors.dart';
import 'package:daroon_doctor/global/utils/app_text_style.dart';

Future<void> addOfferPhoto(BuildContext context) async {
  final controller = Get.find<AddOfferController>();
  showCupertinoModalPopup(
    context: context,
    builder: (context) {
      return CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            onPressed: () {
              controller.getGalleryImage();
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
              controller.getCameraImage();
              Navigator.pop(context);
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
