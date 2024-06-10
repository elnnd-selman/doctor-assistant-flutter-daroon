import 'package:get/get.dart';
import 'package:hezr/app/modules/doctor/doctor_appointment/controller/cancel_appointment_controller.dart';

class DoctorAppointmentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CancelAppointmentController());
  }
}
