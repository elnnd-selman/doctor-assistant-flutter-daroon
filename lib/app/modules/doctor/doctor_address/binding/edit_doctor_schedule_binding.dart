import 'package:daroon_doctor/app/modules/doctor/doctor_address/controller/edit_doctor_schedule_controller.dart';
import 'package:get/get.dart';

class EditDoctorScheduleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EditDoctorScheduleController());
  }
}
