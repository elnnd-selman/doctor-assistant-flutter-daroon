import 'package:daroon_doctor/app/modules/doctor/doctor_message/controller/doctor_message_controller.dart';
import 'package:get/get.dart';

class DoctorMesaageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DoctorMessageController());
  }
}
