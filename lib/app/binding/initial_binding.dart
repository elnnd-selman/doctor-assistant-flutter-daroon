import 'package:get/get.dart';
import 'package:daroon_doctor/app/controllers/local_storage_controller.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(LocalStorageController(), permanent: true);
  }
}
