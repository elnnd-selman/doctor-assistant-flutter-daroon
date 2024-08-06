import 'package:daroon_doctor/app/modules/doctor/doctor_address/controller/edit_doctor_address_controller.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_address/model/office_type_model.dart';
import 'package:daroon_doctor/global/constants/app_colors.dart';
import 'package:daroon_doctor/global/constants/size_config.dart';
import 'package:daroon_doctor/global/utils/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class EditOfficeType extends StatelessWidget {
  final OfficeTypeModel officeTypeModel;
  final int index;
  const EditOfficeType({
    super.key,
    required this.officeTypeModel,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<EditDoctorAddressController>();
    return Obx(
      () => Container(
        margin: const EdgeInsets.only(right: 20),
        padding: EdgeInsets.symmetric(
            // vertical: MediaQuery.of(context).size.height * 0.02,
            horizontal: MediaQuery.of(context).size.width * 0.06),
        decoration: BoxDecoration(
            color: const Color(0xff979797).withOpacity(.09),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
                color: controller.slectedOffice.value == index
                    ? AppColors.primaryColor
                    : Colors.transparent)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              officeTypeModel.imageUrl,
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.002,
            ),
            Text(
              officeTypeModel.title,
              style: AppTextStyles.medium.copyWith(
                fontWeight: FontWeight.w400,
                color: AppColors.blackBGColor,
                fontSize: SizeConfig.heightMultiplier * 1.6,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
