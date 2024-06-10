import 'package:get/get.dart';
import 'package:hezr/app/modules/doctor/doctor_offers/controller/doctor_offers_controller.dart';

class DoctorOffersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DoctorOffersController());
  }
}
