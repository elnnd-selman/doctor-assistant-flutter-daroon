import 'package:get/get.dart';
import 'package:hezr/app/modules/doctor/doctor_address/controller/add_doctor_address_controller.dart';

class DoctorAddressBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddDoctorAddressController());
  }
}
