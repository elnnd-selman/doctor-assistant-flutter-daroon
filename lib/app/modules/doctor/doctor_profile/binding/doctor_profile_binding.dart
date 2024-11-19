import 'package:daroon_doctor/app/modules/doctor/doctor_profile/controller/post_comment_controller.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_profile/controller/post_like_user_controller.dart';
import 'package:get/get.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_profile/controller/doctor_edit_profile_controller.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_profile/controller/doctor_language_controller.dart';

class DoctorProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DoctorLanguageController());
    Get.lazyPut(() => DoctorEditProfileController());
    Get.lazyPut(() => PostCommentController());
    Get.lazyPut(() => PostLikeUserController());
  }
}
