import 'package:daroon_doctor/app/modules/doctor/doctor_address/controller/edit_doctor_address_controller.dart';
import 'package:get/get.dart';

class EditDoctorAddressBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EditDoctorAddressController());
  }
}
