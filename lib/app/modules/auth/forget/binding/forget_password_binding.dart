import 'package:get/get.dart';
import 'package:daroon_doctor/app/modules/auth/forget/controller/forget_password_controller.dart';

class ForgetPasswordBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ForgetPasswordCtrl());
  }
}
