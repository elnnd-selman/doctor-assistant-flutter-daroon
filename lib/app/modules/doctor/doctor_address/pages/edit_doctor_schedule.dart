import 'package:daroon_doctor/app/modules/doctor/doctor_address/controller/edit_doctor_schedule_controller.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_address/model/doctor_office_address_model.dart';
import 'package:daroon_doctor/generated/assets.dart';
import 'package:daroon_doctor/global/constants/app_colors.dart';
import 'package:daroon_doctor/global/constants/size_config.dart';
import 'package:daroon_doctor/global/utils/app_text_style.dart';
import 'package:daroon_doctor/global/utils/widget_spacing.dart';
import 'package:daroon_doctor/global/widgets/auth_text_field.dart';
import 'package:daroon_doctor/global/widgets/common_button.dart';
import 'package:daroon_doctor/global/widgets/custom_cupertino_button.dart';
import 'package:daroon_doctor/global/widgets/custom_dialog_box.dart';
import 'package:daroon_doctor/global/widgets/loading_overlay.dart';
import 'package:daroon_doctor/global/widgets/toast_message.dart';
import 'package:duration_picker/duration_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class EditDoctorSchedule extends GetView<EditDoctorScheduleController> {
  EditDoctorSchedule({super.key});
  final officeAddress = Get.arguments[0] as OfficeAddreesModel;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditDoctorScheduleController>(initState: (_) {
      controller.setScheduleAdress(officeAddress);
    }, builder: (_) {
      return Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          shadowColor: Colors.white,
          surfaceTintColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          automaticallyImplyLeading: true,
          title: Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Text(
              "Edit Schedule",
              style: AppTextStyles.medium.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.blackBGColor,
                fontSize: 2 * SizeConfig.heightMultiplier,
              ),
            ),
          ),
          leading: IconButton(
              onPressed: () {
                Get.dialog(
                  CustomDialogBox(
                    onPressedCancel: () {
                      Get.back();
                      Get.back();
                    },
                    title: 'Save change',
                    confirmButtonText: 'Save',
                    onPressedConfirm: () {
                      if (controller.selectedWeekDays.isNotEmpty &&
                          controller.isStartWithTime.value == true &&
                          controller.isEndWithTime.value == true &&
                          controller.istimeDuration.value == true &&
                          controller.feeClinic.text.isNotEmpty &&
                          controller.feeMessage.text.isNotEmpty &&
                          controller.feeVideo.text.isNotEmpty &&
                          controller.feeCall.text.isNotEmpty) {
                        Get.back();
                        controller.updateOffice(
                            context: context, office: officeAddress);
                      } else {
                        showToastMessage(
                            message: "Please Fill all Fields ",
                            context: context,
                            color: const Color(0xffEC1C24),
                            icon: Icons.close);
                      }
                    },
                    subTitle: 'Are you sure you want to\ndiscard the change?',
                  ),
                  barrierColor: AppColors.blackBGColor.withOpacity(0.5),
                );
              },
              icon: const Icon(Icons.arrow_back)),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Available Days",
                      style: AppTextStyles.medium.copyWith(
                        fontWeight: FontWeight.w500,
                        color: const Color(0xff898A8D),
                        fontSize: SizeConfig.heightMultiplier * 1.8,
                      ),
                    ),
                    10.verticalSpace,
                    _buildWeekDaysContainer(context),
                    20.verticalSpace,
                    Text(
                      "Available Time",
                      style: AppTextStyles.medium.copyWith(
                        fontWeight: FontWeight.w500,
                        color: const Color(0xff898A8D),
                        fontSize: SizeConfig.heightMultiplier * 1.8,
                      ),
                    ),
                    10.verticalSpace,
                    Row(
                      children: [
                        Expanded(
                          child: CupertinoButton(
                            pressedOpacity: 0,
                            padding: EdgeInsets.zero,
                            minSize: 0,
                            onPressed: () async {
                              // controller.startWithTime.value =
                              final time = await getTime(context: context);
                              if (time != null) {
                                controller.startWithTime.value = time;
                                controller.isStartWithTime.value = true;
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 20),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: const Color(0xffF7F7F8),
                                  border: Border.all(
                                    color: const Color(0xffE7E8EA),
                                  )),
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    "assets/icons/timerIcon.svg",
                                    height: 25,
                                  ),
                                  10.horizontalSpace,
                                  Obx(
                                    () => Text(
                                      controller.isStartWithTime.value
                                          ? controller.convertTo12HourFormat(
                                              controller
                                                  .startWithTime.value.hour,
                                              controller
                                                  .startWithTime.value.minute)
                                          : "Start with",
                                      style: AppTextStyles.medium.copyWith(
                                        fontWeight: FontWeight.w400,
                                        color: const Color(0xff535353),
                                        fontSize:
                                            SizeConfig.heightMultiplier * 1.8,
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                  SvgPicture.asset(
                                    Assets.arrowDownIcon,
                                    height: 25,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 3 * SizeConfig.widthMultiplier),
                        Expanded(
                          child: CupertinoButton(
                            pressedOpacity: 0,
                            padding: EdgeInsets.zero,
                            minSize: 0,
                            onPressed: () async {
                              final time = await getTime(context: context);
                              if (time != null) {
                                controller.endWithTime.value = time;
                                controller.isEndWithTime.value = true;
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 20),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: const Color(0xffF7F7F8),
                                  border: Border.all(
                                    color: const Color(0xffE7E8EA),
                                  )),
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    "assets/icons/timerIcon.svg",
                                    height: 25,
                                  ),
                                  10.horizontalSpace,
                                  Obx(
                                    () => Text(
                                      controller.isEndWithTime.value
                                          ? controller.convertTo12HourFormat(
                                              controller.endWithTime.value.hour,
                                              controller
                                                  .endWithTime.value.minute)
                                          : "End with",
                                      style: AppTextStyles.medium.copyWith(
                                        fontWeight: FontWeight.w400,
                                        color: const Color(0xff535353),
                                        fontSize:
                                            SizeConfig.heightMultiplier * 1.8,
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                  SvgPicture.asset(
                                    Assets.arrowDownIcon,
                                    height: 25,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    20.verticalSpace,
                    Text(
                      "Appointment Duration",
                      style: AppTextStyles.medium.copyWith(
                        fontWeight: FontWeight.w500,
                        color: const Color(0xff898A8D),
                        fontSize: SizeConfig.heightMultiplier * 1.8,
                      ),
                    ),
                    10.verticalSpace,
                    Row(
                      children: [
                        Expanded(
                          child: CupertinoButton(
                            pressedOpacity: 0,
                            padding: EdgeInsets.zero,
                            minSize: 0,
                            onPressed: () async {
                              final time = await getTimeDuration(context);
                              if (time != null) {
                                controller.timeDuration.value = time;
                                controller.istimeDuration.value = true;
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 20),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: const Color(0xffF7F7F8),
                                  border: Border.all(
                                    color: const Color(0xffE7E8EA),
                                  )),
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    "assets/icons/timerIcon.svg",
                                    height: 25,
                                  ),
                                  10.horizontalSpace,
                                  Obx(
                                    () => Text(
                                      controller.istimeDuration.value
                                          ? "${controller.separeteHours(controller.timeDuration.value.inMinutes)} hours"
                                              .toString()
                                          : "Hours",
                                      style: AppTextStyles.medium.copyWith(
                                        fontWeight: FontWeight.w400,
                                        color: const Color(0xff535353),
                                        fontSize:
                                            SizeConfig.heightMultiplier * 1.8,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 3 * SizeConfig.widthMultiplier),
                        Expanded(
                          child: CupertinoButton(
                            pressedOpacity: 0,
                            padding: EdgeInsets.zero,
                            minSize: 0,
                            onPressed: () async {
                              final time = await getTimeDuration(context);
                              if (time != null) {
                                controller.timeDuration.value = time;
                                controller.istimeDuration.value = true;
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 20),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: const Color(0xffF7F7F8),
                                  border: Border.all(
                                    color: const Color(0xffE7E8EA),
                                  )),
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    "assets/icons/timerIcon.svg",
                                    height: 25,
                                  ),
                                  10.horizontalSpace,
                                  Obx(
                                    () => Text(
                                      controller.istimeDuration.value
                                          ? "${controller.separeteMinutes(controller.timeDuration.value.inMinutes)} min"
                                          : "Min",
                                      style: AppTextStyles.medium.copyWith(
                                        fontWeight: FontWeight.w400,
                                        color: const Color(0xff535353),
                                        fontSize:
                                            SizeConfig.heightMultiplier * 1.8,
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                  SvgPicture.asset(
                                    Assets.arrowDownIcon,
                                    height: 25,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    25.verticalSpace,
                    Text(
                      "Fee Information",
                      style: AppTextStyles.medium.copyWith(
                        fontWeight: FontWeight.w500,
                        color: const Color(0xff898A8D),
                        fontSize: SizeConfig.heightMultiplier * 1.8,
                      ),
                    ),
                    20.verticalSpace,
                    _buildTitle("Fee (In-clinic )", Assets.locationIcon),
                    10.verticalSpace,
                    AddressTextField(
                      scanIcons: false,
                      obscuretext: false,
                      hinttext: "0.0",
                      controller: controller.feeClinic,
                      keyboardType: TextInputType.number,
                      showicon: false,
                      validations: (value) {
                        if (value!.isEmpty) {
                          return "Enter Enter Clinic Fees";
                        }
                        return null;
                      },
                    ),
                    20.verticalSpace,
                    _buildTitle("Fee (Message )", Assets.messageIcon),
                    10.verticalSpace,
                    AddressTextField(
                      scanIcons: false,
                      obscuretext: false,
                      hinttext: "0.0",
                      controller: controller.feeMessage,
                      keyboardType: TextInputType.number,
                      showicon: false,
                      validations: (value) {
                        if (value!.isEmpty) {
                          return "Enter Enter Clinic Fees";
                        }
                        return null;
                      },
                    ),
                    20.verticalSpace,
                    _buildTitle("Fee (Call)", "assets/icons/phoneIcon.svg"),
                    10.verticalSpace,
                    AddressTextField(
                      scanIcons: false,
                      obscuretext: false,
                      hinttext: "0.0",
                      controller: controller.feeCall,
                      keyboardType: TextInputType.number,
                      showicon: false,
                      validations: (value) {
                        if (value!.isEmpty) {
                          return "Enter Enter Clinic Fees";
                        }
                        return null;
                      },
                    ),
                    20.verticalSpace,
                    _buildTitle("Fee (Video)", "assets/icons/videoCall.svg"),
                    10.verticalSpace,
                    AddressTextField(
                      scanIcons: false,
                      obscuretext: false,
                      hinttext: "0.0",
                      controller: controller.feeVideo,
                      keyboardType: TextInputType.number,
                      showicon: false,
                      validations: (value) {
                        if (value!.isEmpty) {
                          return "Enter  Video Fees";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 3 * SizeConfig.heightMultiplier),
                    CommonButton(
                        ontap: () {
                          if (controller.selectedWeekDays.isNotEmpty &&
                              controller.isStartWithTime.value == true &&
                              controller.isEndWithTime.value == true &&
                              controller.istimeDuration.value == true &&
                              controller.feeClinic.text.isNotEmpty &&
                              controller.feeMessage.text.isNotEmpty &&
                              controller.feeVideo.text.isNotEmpty &&
                              controller.feeCall.text.isNotEmpty) {
                            Get.dialog(
                              CustomDialogBox(
                                title: 'Save change',
                                confirmButtonText: 'Save',
                                onPressedCancel: () {
                                  Get.back();
                                },
                                onPressedConfirm: () {
                                  Get.back();
                                  controller.updateOffice(
                                      context: context, office: officeAddress);
                                },
                                subTitle:
                                    'Are you sure you want to\ndiscard the change?',
                              ),
                              barrierColor:
                                  AppColors.blackBGColor.withOpacity(0.5),
                            );
                          } else {
                            showToastMessage(
                                message: "Please Fill all Fields ",
                                context: context,
                                color: const Color(0xffEC1C24),
                                icon: Icons.close);
                          }
                        },
                        name: "Save"),
                    SizedBox(height: 3 * SizeConfig.heightMultiplier),
                  ],
                ),
              ),
              Obx(() {
                if (controller.processing) {
                  return const LoadingOverlay();
                }
                return const SizedBox();
              }),
            ],
          ),
        ),
      );
    });
  }

  Row _buildTitle(String title, String icon) {
    return Row(
      children: [
        4.horizontalSpace,
        SvgPicture.asset(
          icon,
          colorFilter: const ColorFilter.mode(
            AppColors.primaryColor,
            BlendMode.srcIn,
          ),
          height: 20,
        ),
        10.horizontalSpace,
        Text(
          title,
          style: AppTextStyles.medium.copyWith(
            fontWeight: FontWeight.w500,
            color: const Color(0xff898A8D),
            fontSize: SizeConfig.heightMultiplier * 1.8,
          ),
        ),
      ],
    );
  }

  Future<TimeOfDay?> getTime({
    required BuildContext context,
    String? title,
    TimeOfDay? initialTime,
    String? cancelText,
    String? confirmText,
  }) async {
    TimeOfDay? time = await showTimePicker(
      initialEntryMode: TimePickerEntryMode.dial,
      context: context,
      initialTime: initialTime ?? TimeOfDay.now(),
      cancelText: cancelText ?? "Cancel",
      confirmText: confirmText ?? "Save",
      helpText: title ?? "Select time",
      builder: (context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child!,
        );
      },
    );

    return time;
  }

  Container _buildWeekDaysContainer(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.09,
      width: MediaQuery.of(context).size.width * 1,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xffE0E0E0),
        ),
      ),
      child: Center(
        child: ListView.builder(
          itemCount: controller.weekDaysList.length,
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return CustomCupertinoButton(
              onTap: () {
                if (controller.selectedWeekDays
                    .contains(controller.weekDaysListFull[index])) {
                  controller.selectedWeekDays.removeWhere(
                      (item) => item == controller.weekDaysListFull[index]);
                } else {
                  controller.selectedWeekDays
                      .add(controller.weekDaysListFull[index]);
                }
              },
              child: Obx(
                () => Container(
                  width: MediaQuery.of(context).size.width * 0.12,
                  margin: EdgeInsets.only(right: index == 7 ? 0 : 10),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: controller.selectedWeekDays
                              .contains(controller.weekDaysListFull[index])
                          ? AppColors.primaryColor
                          : const Color(0xffE0E0E0),
                    ),
                    color: controller.selectedWeekDays
                            .contains(controller.weekDaysListFull[index])
                        ? AppColors.primaryColor
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      controller.weekDaysList[index],
                      style: AppTextStyles.medium.copyWith(
                        fontWeight: FontWeight.w500,
                        color: controller.selectedWeekDays
                                .contains(controller.weekDaysListFull[index])
                            ? AppColors.whiteBGColor
                            : AppColors.blackBGColor,
                        fontSize: SizeConfig.heightMultiplier * 1.5,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  getTimeDuration(BuildContext context) async {
    var timeDuration = await showDurationPicker(
        context: context,
        initialTime: const Duration(minutes: 0),
        decoration: BoxDecoration(
          color: AppColors.whiteBGColor,
          borderRadius: BorderRadius.circular(12),
        ));

    return timeDuration;
  }
}
