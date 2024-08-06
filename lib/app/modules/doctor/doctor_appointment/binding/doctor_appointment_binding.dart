import 'package:get/get.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_appointment/controller/cancel_appointment_controller.dart';

class DoctorAppointmentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CancelAppointmentController());
  }
}
