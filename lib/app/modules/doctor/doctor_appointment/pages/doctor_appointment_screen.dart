import 'package:flutter/material.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_appointment/pages/cancel_appointment.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_appointment/pages/complete_appointment.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_appointment/pages/confirmed_appointment.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_appointment/pages/upcoming_appointment.dart';
import 'package:daroon_doctor/global/constants/app_colors.dart';
import 'package:daroon_doctor/global/utils/app_text_style.dart';
import 'package:daroon_doctor/global/utils/widget_spacing.dart';

class DoctorAppointmentScreen extends StatefulWidget {
  const DoctorAppointmentScreen({super.key});

  @override
  State<DoctorAppointmentScreen> createState() =>
      _DoctorAppointmentScreenState();
}

class _DoctorAppointmentScreenState extends State<DoctorAppointmentScreen> {
  TabController? _tabController;
  // final exploreCtrl = Get.put(ExploreProgramController());

  List<Widget> appointmentBasetabs = [
    const Tab(text: "Upcoming"),
    const Tab(text: "Confirmed"),
    const Tab(text: "Completed"),
    const Tab(text: "Cancelled"),
  ];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
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
            child: TabBarView(
              controller: _tabController,
              children: const [
                UpcomingAppointment(),
                ConfirmedAppointment(),
                CompleteAppointment(),
                CancelAppointment(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
