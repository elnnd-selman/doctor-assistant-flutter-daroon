import 'package:get/get.dart';
import 'package:hezr/app/modules/user/user_offer/controller/user_offers_controller.dart';
import 'package:hezr/app/modules/user/user_top_doctors/controller/user_top_doctor_controller.dart';

class UserTopDoctorBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut(() => UserTopDoctorController());
  }
}
