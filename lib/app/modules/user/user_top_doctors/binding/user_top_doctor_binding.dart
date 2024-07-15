import 'package:get/get.dart';
import 'package:hezr/app/modules/user/user_top_doctors/controller/filter_controller.dart';

class UserTopDoctorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FilterController());
  }
}
