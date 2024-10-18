import 'package:daroon_doctor/app/modules/doctor/doctor_offers/controller/add_offer_controller.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_offers/controller/offer_edit_controller.dart';
import 'package:get/get.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_offers/controller/doctor_offers_controller.dart';

class DoctorOffersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DoctorOffersController());
    Get.lazyPut(() => AddOfferController());
    Get.lazyPut(() => OfferEditController());
  }
}
