import 'package:daroon_doctor/app/modules/doctor/doctor_appointment/controller/doctor_appointment_controller.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_appointment/pages/request_appointment.dart';
import 'package:daroon_doctor/global/constants/size_config.dart';
import 'package:daroon_doctor/global/widgets/loading_overlay.dart';
import 'package:flutter/material.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_appointment/pages/cancel_appointment.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_appointment/pages/complete_appointment.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_appointment/pages/confirmed_appointment.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_appointment/pages/upcoming_appointment.dart';
import 'package:daroon_doctor/global/constants/app_colors.dart';
import 'package:daroon_doctor/global/utils/app_text_style.dart';
import 'package:daroon_doctor/global/utils/widget_spacing.dart';
import 'package:get/get.dart';

class DoctorAppointmentScreen extends StatefulWidget {
  const DoctorAppointmentScreen({super.key});

  @override
  State<DoctorAppointmentScreen> createState() =>
      _DoctorAppointmentScreenState();
}

class _DoctorAppointmentScreenState extends State<DoctorAppointmentScreen> {
  TabController? _tabController;
  final controller = Get.put(DoctorAppointmentController());

  List<Widget> appointmentBasetabs = [
    const Tab(text: "Upcoming"),
    const Tab(text: "Confirmed"),
    const Tab(text: "Completed"),
    const Tab(text: "Cancelled"),
    const Tab(text: "Request"),
  ];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          10.verticalSpace,
          SizedBox(
            height: 30,
            child: TabBar(
              controller: _tabController,
              tabAlignment: TabAlignment.start,
              labelPadding: const EdgeInsets.only(left: 25, bottom: 10),
              isScrollable: true,
              labelStyle: AppTextStyles.semiBold.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 15,
                color: AppColors.primaryColor,
              ),
              overlayColor: WidgetStateProperty.all(Colors.transparent),
              indicatorColor: AppColors.primaryColor,
              unselectedLabelStyle: AppTextStyles.semiBold.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 15,
                color: const Color(0xff979797),
              ),
              tabs: appointmentBasetabs,
            ),
          ),
          Expanded(
              child: Obx(
            () => TabBarView(
              controller: _tabController,
              children: [
                const UpcomingAppointment(),
                controller.isLoading.value
                    ? const LoadingWidget()
                    : controller.confirmedAppointmentList.isEmpty
                        ? Center(
                            child: Text(
                              "No Confirmed appointment\nis found.",
                              textAlign: TextAlign.center,
                              style: AppTextStyles.medium.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.lighttextColor),
                            ),
                          )
                        : ListView.builder(
                            padding: EdgeInsets.only(
                                top: 2 * SizeConfig.heightMultiplier),
                            shrinkWrap: true,
                            itemCount:
                                controller.confirmedAppointmentList.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.only(
                                    bottom: index ==
                                            controller.confirmedAppointmentList
                                                    .length -
                                                1
                                        ? 12 * SizeConfig.heightMultiplier
                                        : 0),
                                child: ConfirmedAppointment(
                                    appointmentModel: controller
                                        .confirmedAppointmentList[index]),
                              );
                            }),
                controller.isLoading.value
                    ? const LoadingWidget()
                    : controller.completedAppointmentList.isEmpty
                        ? Center(
                            child: Text(
                              "No Completed appointment\nis found.",
                              textAlign: TextAlign.center,
                              style: AppTextStyles.medium.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.lighttextColor),
                            ),
                          )
                        : ListView.builder(
                            padding: EdgeInsets.only(
                                top: 2 * SizeConfig.heightMultiplier),
                            shrinkWrap: true,
                            itemCount:
                                controller.completedAppointmentList.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.only(
                                    bottom: index ==
                                            controller.completedAppointmentList
                                                    .length -
                                                1
                                        ? 12 * SizeConfig.heightMultiplier
                                        : 0),
                                child: CompleteAppointment(
                                  appointmentModel: controller
                                      .completedAppointmentList[index],
                                ),
                              );
                            }),
                controller.isLoading.value
                    ? const LoadingWidget()
                    : controller.cancelAppointmentList.isEmpty
                        ? Center(
                            child: Text(
                              "No Cancel appointment\nis found.",
                              textAlign: TextAlign.center,
                              style: AppTextStyles.medium.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.lighttextColor),
                            ),
                          )
                        : ListView.builder(
                            padding: EdgeInsets.only(
                                top: 2 * SizeConfig.heightMultiplier),
                            shrinkWrap: true,
                            itemCount: controller.cancelAppointmentList.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.only(
                                    bottom: index ==
                                            controller.cancelAppointmentList
                                                    .length -
                                                1
                                        ? 12 * SizeConfig.heightMultiplier
                                        : 0),
                                child: CancelAppointment(
                                  appointmentModel:
                                      controller.cancelAppointmentList[index],
                                ),
                              );
                            }),
                controller.isLoading.value
                    ? const LoadingWidget()
                    : controller.requestAppointmentList.isEmpty
                        ? Center(
                            child: Text(
                              "No Request appointment\nis found.",
                              textAlign: TextAlign.center,
                              style: AppTextStyles.medium.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.lighttextColor),
                            ),
                          )
                        : ListView.builder(
                            padding: EdgeInsets.only(
                                top: 2 * SizeConfig.heightMultiplier),
                            shrinkWrap: true,
                            itemCount: controller.requestAppointmentList.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.only(
                                    bottom: index ==
                                            controller.requestAppointmentList
                                                    .length -
                                                1
                                        ? 12 * SizeConfig.heightMultiplier
                                        : 0),
                                child: RequestAppointment(
                                  appointmentModel:
                                      controller.requestAppointmentList[index],
                                ),
                              );
                            },
                          ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}
