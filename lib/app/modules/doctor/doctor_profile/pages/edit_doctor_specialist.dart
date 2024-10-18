import 'package:daroon_doctor/app/modules/doctor/doctor_profile/controller/doctor_edit_speciality_controller.dart';
import 'package:daroon_doctor/global/constants/app_colors.dart';
import 'package:daroon_doctor/global/constants/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class DoctorSpecialtyContainer extends GetView<DoctorEditSpecialityController> {
  const DoctorSpecialtyContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.specialityDataList.isEmpty
          ? const Center(child: Text("No Speciality Available"))
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 10,
                mainAxisSpacing: 3,
                crossAxisCount: 4,
              ),
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: controller.specialityDataList.length,
              itemBuilder: (context, index) {
                return InkWell(
                  splashColor: Colors.transparent,
                  onTap: () {
                    controller.selectedIndex.value = index;
                  },
                  child: Center(
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Obx(
                          () => Positioned(
                            right: 0,
                            child: Container(
                              height: MediaQuery.of(context).size.height * .02,
                              width: MediaQuery.of(context).size.height * 0.02,
                              decoration: BoxDecoration(
                                color: controller.selectedIndex.value == index
                                    ? AppColors.primaryColor
                                    : const Color(0xff898A8D).withOpacity(.22),
                                border: Border.all(
                                    color:
                                        controller.selectedIndex.value == index
                                            ? Colors.transparent
                                            : AppColors.lighttextColor
                                                .withOpacity(.3)),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.check,
                                size: 11,
                                color: controller.selectedIndex.value == index
                                    ? AppColors.whiteBGColor
                                    : Colors.transparent,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: MediaQuery.of(context).size.height * 0.004,
                          child: Container(
                            height: MediaQuery.of(context).size.height * .07,
                            width: MediaQuery.of(context).size.height * 0.07,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xffebf4ff),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(18),
                              child: SvgPicture.asset(
                                'assets/icons/calendar.svg',
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: MediaQuery.of(context).size.height * 0.004,
                          child: Text(
                            controller.specialityDataList[index].specialityEn!,
                            style: GoogleFonts.roboto(
                              fontWeight: FontWeight.w400,
                              color: const Color(0xff1C1B1F),
                              fontSize: SizeConfig.heightMultiplier * 1.6,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
