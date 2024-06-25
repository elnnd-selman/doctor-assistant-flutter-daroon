import 'package:get/get.dart';
import 'package:hezr/app/modules/doctor/doctor_profile/controller/doctor_edit_profile_controller.dart';
import 'package:hezr/app/modules/doctor/doctor_profile/controller/doctor_language_controller.dart';

class DoctorProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DoctorLanguageController());
    Get.lazyPut(() => DoctorEditProfileController());
  }
}
