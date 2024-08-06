import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_bottom_navi_bar/controller/doctor_custom_navi_controller.dart';
import 'package:daroon_doctor/app/routes/app_routes.dart';
import 'package:daroon_doctor/global/constants/app_colors.dart';
import 'package:daroon_doctor/global/constants/size_config.dart';
import 'package:daroon_doctor/global/utils/app_text_style.dart';

class DoctorLocationAppBar extends GetView<DoctorCustomNaviController> {
  const DoctorLocationAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.14,
      width: MediaQuery.of(context).size.width * 1,
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.06,
            right: MediaQuery.of(context).size.width * 0.06,
            top: MediaQuery.of(context).size.height * 0.04),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          // mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Address",
                  style: AppTextStyles.medium.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.whiteBGColor,
                    fontSize: SizeConfig.heightMultiplier * 2,
                  ),
                )
              ],
            ),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => Get.toNamed(Routes.addDoctorAdress),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.045,
                    width: MediaQuery.of(context).size.height * 0.045,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.whiteBGColor),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.add,
                      color: AppColors.whiteBGColor,
                      size: 25,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );

    //  Row(
    //   mainAxisAlignment: MainAxisAlignment.start,
    //   crossAxisAlignment: CrossAxisAlignment.center,
    //   children: [
    //     Get.find<DoctorHomeController>()
    //                 .userModel
    //                 .value!
    //                 .user!
    //                 .profilePicture ==
    //             null
    //         ? Container(
    //             height: 5 * SizeConfig.heightMultiplier,
    //             width: 5 * SizeConfig.heightMultiplier,
    //             padding: const EdgeInsets.all(10),
    //             decoration: const BoxDecoration(
    //                 color: AppColors.blackBGColor, shape: BoxShape.circle),
    //             child: Center(
    //               child: FittedBox(
    //                 child: Text(
    //                   '${Get.find<DoctorHomeController>().userModel.value!.user!.username![0].toUpperCase()}${Get.find<DoctorHomeController>().userModel.value!.user!.name![0].toUpperCase()}',
    //                   style: AppTextStyles.bold.copyWith(
    //                     color: Colors.white,
    //                     fontSize: Spaces.fontSize(fontSize: 18),
    //                   ),
    //                 ),
    //               ),
    //             ))
    //         : CircleAvatar(
    //             radius: 14,
    //             child: ClipOval(
    //               child: CachedNetworkImage(
    //                 imageUrl: Get.find<DoctorHomeController>()
    //                     .userModel
    //                     .value!
    //                     .user!
    //                     .profilePicture,
    //                 fit: BoxFit.cover,
    //                 height: 5 * SizeConfig.heightMultiplier,
    //                 width: 5 * SizeConfig.heightMultiplier,
    //               ),
    //             ),
    //           ),
    //     14.horizontalSpace,
    //     Column(
    //       crossAxisAlignment: CrossAxisAlignment.center,
    //       children: [
    //         Text(
    //           Get.find<DoctorHomeController>()
    //               .userModel
    //               .value!
    //               .user!
    //               .fullName!,
    //           style: AppTextStyles.medium.copyWith(
    //             fontWeight: FontWeight.w600,
    //             color: AppColors.blackBGColor,
    //             fontSize: SizeConfig.heightMultiplier * 1.8,
    //           ),
    //         ),
    //       ],
    //     )
    //   ],
    // ),
  }
}
