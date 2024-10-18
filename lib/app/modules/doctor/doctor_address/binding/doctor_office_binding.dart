import 'package:daroon_doctor/app/modules/doctor/doctor_address/controller/doctor_address_controller.dart';
import 'package:get/get.dart';

class DoctorOfficeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DoctorAddressController());
  }
}
