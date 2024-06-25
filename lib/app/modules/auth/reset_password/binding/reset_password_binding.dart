import 'package:get/get.dart';
import 'package:hezr/app/modules/auth/reset_password/controller/reset_password_controller.dart';
import 'package:hezr/app/modules/doctor/doctor_assistant/controller/add_assistant_controller.dart';
import 'package:hezr/app/modules/doctor/doctor_assistant/controller/doctor_assistant_controller.dart';

class ResetPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ResetPasswordController());
  }
}
