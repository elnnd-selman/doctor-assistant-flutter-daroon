import 'package:daroon_doctor/app/modules/doctor/doctor_address/controller/doctor_detail_controller.dart';
import 'package:get/get.dart';

class DoctorDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DoctorDetailController());
  }
}
