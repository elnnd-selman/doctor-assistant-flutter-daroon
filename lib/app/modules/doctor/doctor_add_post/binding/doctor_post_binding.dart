import 'package:daroon_doctor/app/modules/doctor/doctor_add_post/controller/doctor_update_post_controller.dart';
import 'package:get/get.dart';

class DoctorPostBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DoctorUpdatePostController());
  }
}
