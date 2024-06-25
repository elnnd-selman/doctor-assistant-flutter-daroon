import 'package:get/get.dart';

class DoctorLanguageController extends GetxController {
  RxInt selectedIndex = 0.obs;

  RxList<String> languageList = [
    "English",
    "Arabic",
    "Kurdish",
  ].obs;
}
