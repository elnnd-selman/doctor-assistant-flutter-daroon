import 'package:get/get.dart';
import 'package:hezr/app/modules/doctor/doctor_assistant/controller/add_assistant_controller.dart';
import 'package:hezr/app/modules/doctor/doctor_assistant/controller/doctor_assistant_controller.dart';

class DoctorAssistantBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DoctorAssistantController());
    Get.lazyPut(() => AddAssistantController());
  }
}
