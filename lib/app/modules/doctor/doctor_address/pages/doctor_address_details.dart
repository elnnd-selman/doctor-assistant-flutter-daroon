import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_address/controller/doctor_address_controller.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_address/controller/doctor_detail_controller.dart';
import 'package:daroon_doctor/app/routes/app_routes.dart';
import 'package:daroon_doctor/global/widgets/custom_dialog_box.dart';
import 'package:daroon_doctor/global/widgets/loading_overlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_address/model/doctor_office_address_model.dart';
import 'package:daroon_doctor/generated/assets.dart';
import 'package:daroon_doctor/global/constants/app_colors.dart';
import 'package:daroon_doctor/global/constants/size_config.dart';
import 'package:daroon_doctor/global/utils/app_text_style.dart';
import 'package:daroon_doctor/global/utils/widget_spacing.dart';

class DoctorAddressDetailsScreen extends GetView<DoctorDetailController> {
  const DoctorAddressDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final officeAddreesModel = Get.arguments[0] as OfficeAddreesModel;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        shadowColor: Colors.white,
        surfaceTintColor: Colors.white,

        elevation: 0,
        // leading: const SizedBox(),
        automaticallyImplyLeading: true,

        title: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Text(
            "Address",
            style: AppTextStyles.medium.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.blackBGColor,
              fontSize: 2 * SizeConfig.heightMultiplier,
            ),
          ),
        ),
        actions: [
          _buildMenu(context, officeAddreesModel),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  10.verticalSpace,
                  Row(
                    children: [
                      Text(
                        "Available Days",
                        style: AppTextStyles.medium.copyWith(
                          fontWeight: FontWeight.w500,
                          color: const Color(0xff898A8D),
                          fontSize: SizeConfig.heightMultiplier * 1.8,
                        ),
                      ),
                      const Spacer(),
                      SvgPicture.asset(
                        Assets.editIcon,
                      ),
                      6.horizontalSpace,
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(
                            Routes.editdoctorSchedule,
                            arguments: [
                              officeAddreesModel,
                            ],
                          );
                        },
                        child: Text(
                          "Edit Schedule",
                          style: AppTextStyles.medium.copyWith(
                            fontWeight: FontWeight.w500,
                            color: AppColors.primaryColor,
                            fontSize: SizeConfig.heightMultiplier * 1.3,
                          ),
                        ),
                      ),
                    ],
                  ),
                  14.verticalSpace,
                  _buildWeekDaysContainer(context, officeAddreesModel),
                  25.verticalSpace,
                  Text(
                    "Available Time",
                    style: AppTextStyles.medium.copyWith(
                      fontWeight: FontWeight.w500,
                      color: const Color(0xff898A8D),
                      fontSize: SizeConfig.heightMultiplier * 1.8,
                    ),
                  ),
                  14.verticalSpace,
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          width: 0.4,
                          color: const Color(0xffE0E0E0),
                        )),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildStartTimeContainer(
                            "To", officeAddreesModel.startTime!),
                        Container(
                          width: 40,
                          height: 2.4,
                          decoration: BoxDecoration(
                            color: const Color(0xff979797),
                            borderRadius: BorderRadius.circular(.4),
                          ),
                        ),
                        _buildStartTimeContainer(
                            "From", officeAddreesModel.endTime!),
                      ],
                    ),
                  ),
                  25.verticalSpace,
                  Text(
                    "Available Time",
                    style: AppTextStyles.medium.copyWith(
                      fontWeight: FontWeight.w500,
                      color: const Color(0xff898A8D),
                      fontSize: SizeConfig.heightMultiplier * 1.8,
                    ),
                  ),
                  14.verticalSpace,
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          width: 0.4,
                          color: const Color(0xffE0E0E0),
                        )),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          "assets/icons/timerIcon.svg",
                          height: 25,
                          colorFilter: const ColorFilter.mode(
                              AppColors.primaryColor, BlendMode.srcIn),
                        ),
                        10.horizontalSpace,
                        Text(
                          "${controller.separeteHours(officeAddreesModel.appointmentDuration!) == 0 ? "" : '${controller.separeteMinutes(officeAddreesModel.appointmentDuration!).toString()} hour : '}${controller.separeteMinutes(officeAddreesModel.appointmentDuration!) == 0 ? "" : '${controller.separeteMinutes(officeAddreesModel.appointmentDuration!).toString()} min'}",
                          style: AppTextStyles.medium.copyWith(
                            fontWeight: FontWeight.w400,
                            color: AppColors.primaryColor,
                            fontSize: SizeConfig.heightMultiplier * 1.8,
                          ),
                        ),
                      ],
                    ),
                  ),
                  25.verticalSpace,
                  Text(
                    "Fees Information",
                    style: AppTextStyles.medium.copyWith(
                      fontWeight: FontWeight.w500,
                      color: const Color(0xff898A8D),
                      fontSize: SizeConfig.heightMultiplier * 1.8,
                    ),
                  ),
                  14.verticalSpace,
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          width: 0.4,
                          color: const Color(0xffE0E0E0),
                        )),
                    child: Column(
                      children: [
                        _buildFeeContainer(
                          title: "In-Clinic",
                          subTitle: "Patient can visit your address.",
                          icon: Assets.locationIcon,
                          fees: officeAddreesModel.fee!.feeClinic!,
                        ),
                        14.verticalSpace,
                        _buildFeeContainer(
                          title: "Messaging",
                          subTitle: "Patient can send message to you.",
                          icon: Assets.messageIcon,
                          fees: officeAddreesModel.fee!.feeMessage!,
                        ),
                        14.verticalSpace,
                        _buildFeeContainer(
                          title: "Call",
                          subTitle: "Patient can call to your phone number.",
                          icon: "assets/icons/phoneIcon.svg",
                          fees: officeAddreesModel.fee!.feeCall!,
                        ),
                        14.verticalSpace,
                        _buildFeeContainer(
                          title: "Video Call",
                          subTitle: "Use video to consultant.",
                          icon: Assets.videoCallIcon,
                          fees: officeAddreesModel.fee!.feeVideoCall!,
                        ),
                      ],
                    ),
                  ),
                  25.verticalSpace,
                  Row(
                    children: [
                      Text(
                        "Address",
                        style: AppTextStyles.medium.copyWith(
                          fontWeight: FontWeight.w500,
                          color: AppColors.blackBGColor,
                          fontSize: SizeConfig.heightMultiplier * 1.8,
                        ),
                      ),
                      const Spacer(),
                      SvgPicture.asset(
                        Assets.editIcon,
                      ),
                      6.horizontalSpace,
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(Routes.editdoctorAdress, arguments: [
                            officeAddreesModel,
                          ]);
                        },
                        child: Text(
                          "Edit Address",
                          style: AppTextStyles.medium.copyWith(
                            fontWeight: FontWeight.w500,
                            color: AppColors.primaryColor,
                            fontSize: SizeConfig.heightMultiplier * 1.3,
                          ),
                        ),
                      ),
                    ],
                  ),
                  10.verticalSpace,
                  Container(
                    height: 0.5,
                    color: const Color(0xffE0E0E0),
                  ),
                  14.verticalSpace,
                  Row(
                    children: [
                      Column(
                        children: [
                          SvgPicture.asset(
                            Assets.locationIcon,
                            height: 30,
                            colorFilter: const ColorFilter.mode(
                                AppColors.primaryColor, BlendMode.srcIn),
                          ),
                        ],
                      ),
                      SizedBox(width: 2 * SizeConfig.heightMultiplier),
                      Flexible(
                        child: Column(
                          children: [
                            Text(
                              officeAddreesModel.description!,
                              maxLines: 2,
                              style: AppTextStyles.black.copyWith(
                                fontWeight: FontWeight.w400,
                                color: AppColors.blackBGColor,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  GetBuilder<DoctorDetailController>(initState: (_) {
                    controller.setGoogleMapIcon();
                  }, builder: (ctrl) {
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 20),
                      height: MediaQuery.of(context).size.height * 0.22,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: const Color(0xffE0E0E0),
                          )),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: ctrl.isGoogleMapLoading.value
                            ? const Center(child: LoadingWidget())
                            : GoogleMap(
                                markers: {
                                  Marker(
                                    // ignore: deprecated_member_use
                                    icon: BitmapDescriptor.fromBytes(
                                        ctrl.markerIcon),
                                    markerId: const MarkerId('m1'),
                                    position: LatLng(
                                        officeAddreesModel
                                            .address!.coordinate!.latitude!,
                                        officeAddreesModel
                                            .address!.coordinate!.longitude!),
                                    infoWindow: InfoWindow(
                                        title: officeAddreesModel.title,
                                        snippet:
                                            officeAddreesModel.description),
                                  ),
                                },
                                mapType: MapType.terrain,
                                initialCameraPosition: CameraPosition(
                                  target: LatLng(
                                      officeAddreesModel
                                          .address!.coordinate!.latitude!,
                                      officeAddreesModel
                                          .address!.coordinate!.longitude!),
                                  zoom: 12.4746,
                                ),
                                myLocationEnabled: true,
                                onMapCreated:
                                    (GoogleMapController controller) {},
                              ),
                      ),
                    );
                  }),
                  SizedBox(height: 4 * SizeConfig.heightMultiplier)
                ],
              ),
              Obx(() {
                if (Get.find<DoctorAddressController>().isDeleting.value) {
                  return const LoadingOverlay();
                }
                return const SizedBox();
              }),
            ],
          ),
        ),
      ),
    );
  }

  Container _buildFeeContainer({
    required String title,
    required String subTitle,
    required String icon,
    required int fees,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xffF7F5FF),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset(
                icon,
                colorFilter: const ColorFilter.mode(
                    AppColors.primaryColor, BlendMode.srcIn),
              ),
            ),
          ),
          10.horizontalSpace,
          SizedBox(
            width: MediaQuery.of(Get.context!).size.width * 0.5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.medium.copyWith(
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryColor,
                    fontSize: SizeConfig.heightMultiplier * 1.8,
                  ),
                ),
                2.verticalSpace,
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        subTitle,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.medium.copyWith(
                          fontWeight: FontWeight.w400,
                          color: const Color(0xff8E8E95),
                          fontSize: SizeConfig.heightMultiplier * 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Spacer(),
          Text(
            "\$ ${fees.toString()}",
            style: AppTextStyles.medium.copyWith(
              fontWeight: FontWeight.w500,
              color: AppColors.primaryColor,
              fontSize: SizeConfig.heightMultiplier * 2,
            ),
          ),
        ],
      ),
    );
  }

  Column _buildStartTimeContainer(String title, String time) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.medium.copyWith(
            fontWeight: FontWeight.w400,
            color: AppColors.lighttextColor,
            fontSize: SizeConfig.heightMultiplier * 1.6,
          ),
        ),
        4.verticalSpace,
        Text(
          controller.convert24HourTo12Hour(time),
          style: AppTextStyles.medium.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.primaryColor,
            fontSize: SizeConfig.heightMultiplier * 1.8,
          ),
        ),
      ],
    );
  }

  Container _buildWeekDaysContainer(
      BuildContext context, OfficeAddreesModel office) {
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
            return Obx(
              () => Container(
                width: MediaQuery.of(context).size.width * 0.12,
                margin: EdgeInsets.only(right: index == 7 ? 0 : 10),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: office.daysOpen
                            .contains(controller.weekDaysListFull[index])
                        ? AppColors.primaryColor
                        : const Color(0xffE0E0E0),
                  ),
                  color: office.daysOpen
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
                      color: office.daysOpen
                              .contains(controller.weekDaysListFull[index])
                          ? AppColors.whiteBGColor
                          : AppColors.blackBGColor,
                      fontSize: SizeConfig.heightMultiplier * 1.5,
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

  _buildMenu(BuildContext context, OfficeAddreesModel officeAddreesModel) {
    return CustomPopupMenu(
      arrowColor: Colors.white,
      position: PreferredPosition.bottom,
      menuBuilder: () => ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(5)),
          child: IntrinsicWidth(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: controller.menuList
                  .map(
                    (item) => GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        controller.customPopupMenuController.hideMenu();

                        if (item == "Delete") {
                          Get.dialog(
                            CustomDialogBox(
                              title: 'Delete Office Adreess',
                              iconPath: Assets.deleteIcon,
                              onPressedConfirm: () {
                                Get.back();
                                Get.find<DoctorAddressController>()
                                    .deleteOffice(
                                        data: officeAddreesModel,
                                        context: context,
                                        isMainPage: false);
                              },
                              confirmButtonColor: const Color(0xffEC1C24),
                              subTitle:
                                  'Are you sure you want to\ndelete ${officeAddreesModel.title} ?',
                            ),
                            barrierColor:
                                AppColors.blackBGColor.withOpacity(0.5),
                          );
                        }
                      },
                      child: Column(
                        children: [
                          Container(
                            color: Colors.white,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    item,
                                    style: AppTextStyles.medium.copyWith(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: const Color(0xffEC1C24)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ),
      pressType: PressType.singleClick,
      verticalMargin: -10,
      showArrow: false,
      horizontalMargin: 30,
      controller: controller.customPopupMenuController,
      child: Container(
        margin: const EdgeInsets.only(right: 24),
        height: 22,
        width: 22,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: SvgPicture.asset(Assets.moreDotIcon),
      ),
    );
  }
}
