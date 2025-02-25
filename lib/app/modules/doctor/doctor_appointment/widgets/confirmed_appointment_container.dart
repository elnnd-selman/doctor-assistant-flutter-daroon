import 'package:animate_do/animate_do.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_appointment/controller/doctor_appointment_controller.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_appointment/model/doctor_appointmet_model.dart';
import 'package:daroon_doctor/global/widgets/custom_cupertino_button.dart';
import 'package:daroon_doctor/global/widgets/network_image_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_home/widget/upcoming_custom_container.dart';
import 'package:daroon_doctor/app/routes/app_routes.dart';
import 'package:daroon_doctor/generated/assets.dart';
import 'package:daroon_doctor/global/constants/app_colors.dart';
import 'package:daroon_doctor/global/constants/size_config.dart';
import 'package:daroon_doctor/global/utils/app_text_style.dart';
import 'package:daroon_doctor/global/utils/widget_spacing.dart';
import 'package:intl/intl.dart';

class ConfirmedAppointmentContainer extends StatelessWidget {
  final AppointmentModel appointmentModel;
  const ConfirmedAppointmentContainer(
      {super.key, required this.appointmentModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: 3 * SizeConfig.widthMultiplier,
          vertical: 1.5 * SizeConfig.heightMultiplier),
      child: CustomPaint(
        size: Size(MediaQuery.of(context).size.width * 0.8,
            (MediaQuery.of(context).size.height * 0.37)),
        painter: RPSCustomPainters(),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 1,
          height: (MediaQuery.of(context).size.height * 0.38).toDouble(),
          child: Stack(
            children: [
              _startButton(),
              Positioned(
                top: 0,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 5 * SizeConfig.widthMultiplier),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 4 * SizeConfig.heightMultiplier),
                      CustomCupertinoButton(
                        onTap: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          Get.toNamed(Routes.doctorAppointmentDetail,
                              arguments: [
                                "Completed",
                                "confirmed",
                                AppColors.primaryColor,
                                false,
                                "Confirmed Appointment",
                                true,
                                true,
                                appointmentModel,
                              ]);
                        },
                        child: Center(
                          child: Container(
                            color: Colors.transparent,
                            width: MediaQuery.of(context).size.width * 0.83,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: NetWorkImageLoader(
                                    containerColor: Colors.black54,
                                    imageURL: appointmentModel
                                        .bookedBy!.profilePicture!.bg!,
                                    height: 9 * SizeConfig.heightMultiplier,
                                    width: 18 * SizeConfig.widthMultiplier,
                                  ),
                                ),
                                14.horizontalSpace,
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      appointmentModel.fullName!,
                                      style: AppTextStyles.medium.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.primaryColor,
                                        fontSize:
                                            SizeConfig.heightMultiplier * 2.2,
                                      ),
                                    ),
                                    Text(
                                      appointmentModel.bookedFor!,
                                      style: AppTextStyles.medium.copyWith(
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xff737373),
                                        fontSize:
                                            SizeConfig.heightMultiplier * 1.8,
                                      ),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(
                                          top: SizeConfig.heightMultiplier *
                                              0.8),
                                      height: 7 * SizeConfig.heightMultiplier,
                                      width: 7 * SizeConfig.widthMultiplier,
                                      decoration: const BoxDecoration(
                                        color: AppColors.primaryColor,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Image.asset(
                                          Assets.phone,
                                          color: AppColors.whiteBGColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 2 * SizeConfig.heightMultiplier),
                      CustomCupertinoButton(
                        onTap: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          Get.toNamed(Routes.doctorAppointmentDetail,
                              arguments: [
                                "Completed",
                                "confirmed",
                                AppColors.primaryColor,
                                false,
                                "Confirmed Appointment",
                                true,
                                true,
                                appointmentModel,
                              ]);
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          padding: EdgeInsets.symmetric(
                              horizontal: SizeConfig.widthMultiplier * 4,
                              vertical: SizeConfig.heightMultiplier * 2),
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color(0xffC4C4C4).withOpacity(0.5),
                              ),
                              borderRadius: BorderRadius.circular(20)),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    "assets/icons/clock.svg",
                                    height: SizeConfig.heightMultiplier * 2.8,
                                  ),
                                  8.horizontalSpace,
                                  Text(
                                    formatDate(appointmentModel.appointmentDate
                                        .toString()),
                                    style: AppTextStyles.medium.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.primaryColor,
                                      fontSize:
                                          SizeConfig.heightMultiplier * 1.6,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                  height: SizeConfig.heightMultiplier * 1.7),
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    Assets.locationIcon,
                                    height: SizeConfig.heightMultiplier * 2.8,
                                    colorFilter: const ColorFilter.mode(
                                        Color(0xff979797), BlendMode.srcIn),
                                  ),
                                  8.horizontalSpace,
                                  Text(
                                    appointmentModel.office!.description!,
                                    style: AppTextStyles.medium.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.primaryColor,
                                      fontSize:
                                          SizeConfig.heightMultiplier * 1.6,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 2.5 * SizeConfig.heightMultiplier),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Row(
                          children: [
                            Expanded(
                              child: CustomCupertinoButton(
                                onTap: () {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  Get.toNamed(
                                    Routes.cancelAppointment,
                                    arguments: [
                                      appointmentModel,
                                      "upcoming",
                                      true
                                    ],
                                  );
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    // horizontal: SizeConfig.widthMultiplier * 2,
                                    vertical: SizeConfig.heightMultiplier * 1.4,
                                  ),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                          color: AppColors.primaryColor)),
                                  child: Center(
                                    child: Text(
                                      "Cancel",
                                      style: AppTextStyles.medium.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.primaryColor,
                                        fontSize:
                                            SizeConfig.heightMultiplier * 1.7,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            20.horizontalSpace,
                            Expanded(
                              child: CustomCupertinoButton(
                                onTap: () {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  Get.find<DoctorAppointmentController>()
                                      .confirmAppointment(
                                    appointmentModel,
                                    context,
                                    "completed",
                                    true,
                                  );
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical:
                                          SizeConfig.heightMultiplier * 1.4),
                                  decoration: BoxDecoration(
                                      color: AppColors.primaryColor,
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                          color: AppColors.primaryColor)),
                                  child: Center(
                                    child: Text(
                                      "Complete",
                                      style: AppTextStyles.medium.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.whiteBGColor,
                                        fontSize:
                                            SizeConfig.heightMultiplier * 1.7,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  String formatDate(String inputDate) {
    DateTime dateTime = DateTime.parse(inputDate);
    String formattedDate = DateFormat("EEE, MMM d, h:mma").format(dateTime);

    return formattedDate;
  }

  Positioned _startButton() {
    return Positioned(
      right: 2 * SizeConfig.widthMultiplier,
      top: 4,
      child: FadeInRight(
          child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.widthMultiplier * 3.5,
            vertical: SizeConfig.heightMultiplier * 1),
        decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(20)),
        child: Row(
          children: [
            Text(
              "Details",
              style: AppTextStyles.medium.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.whiteBGColor,
                fontSize: SizeConfig.heightMultiplier * 1.2,
              ),
            ),
            SizedBox(width: SizeConfig.widthMultiplier * 0.5),
            Icon(
              Icons.arrow_forward_ios,
              color: AppColors.whiteBGColor,
              size: SizeConfig.heightMultiplier * 1.2,
            )
          ],
        ),
      )),
    );
  }
}
