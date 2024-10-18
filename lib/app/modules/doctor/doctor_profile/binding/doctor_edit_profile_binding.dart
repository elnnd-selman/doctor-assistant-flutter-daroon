import 'package:daroon_doctor/app/modules/doctor/doctor_profile/controller/doctor_change_email_controller.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_profile/controller/doctor_change_username_controller.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_profile/controller/doctor_edit_level_controller.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_profile/controller/doctor_edit_speciality_controller.dart';
import 'package:get/get.dart';

class DoctorEditProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DoctorEditSpecialityController());
    Get.lazyPut(() => DoctorEditLevelCtrl());
    Get.lazyPut(() => DoctorChangeEmailController());
    Get.lazyPut(() => DoctorChangeUserNameController());
  }
}
