import 'package:get/get.dart';
import 'package:hezr/app/modules/doctor/doctor_add_post/controller/doctor_add_post_controller.dart';
import 'package:hezr/app/modules/doctor/doctor_appointment/controller/doctor_appointment_controller.dart';
import 'package:hezr/app/modules/doctor/doctor_bottom_navi_bar/controller/doctor_custom_navi_controller.dart';
import 'package:hezr/app/modules/doctor/doctor_home/controller/doctor_home_controller.dart';
import 'package:hezr/app/modules/doctor/doctor_profile/controller/doctor_profile_controller.dart';

class DoctorHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DoctorCustomNaviController());
    Get.lazyPut(() => DoctorHomeController());
    Get.lazyPut(() => DoctorAppointmentController());
    Get.lazyPut(() => DoctorProfileController());
    Get.lazyPut(() => DoctorAddPostController());
  }
}
