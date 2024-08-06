import 'package:get/get.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_offers/controller/doctor_offers_controller.dart';

class DoctorOffersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DoctorOffersController());
  }
}
