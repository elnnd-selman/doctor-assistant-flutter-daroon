import 'package:get/get.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_address/controller/add_doctor_address_controller.dart';

class DoctorAddressBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddDoctorAddressController());
  }
}
