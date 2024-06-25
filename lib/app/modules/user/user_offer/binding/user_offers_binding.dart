import 'package:get/get.dart';
import 'package:hezr/app/modules/user/user_offer/controller/user_offers_controller.dart';

class UserOffersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UserOffersController());
  }
}
