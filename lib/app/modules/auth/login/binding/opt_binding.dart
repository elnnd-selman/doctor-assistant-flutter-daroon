import 'package:get/get.dart';
import 'package:hezr/app/modules/auth/signup/controller/opt_controller.dart';

class OptBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OptController());
  }
}
