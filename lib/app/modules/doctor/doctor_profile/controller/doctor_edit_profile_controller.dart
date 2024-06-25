import 'package:get/get.dart';

class DoctorEditProfileController extends GetxController {
  RxList<String> levelList = ['Level 1', 'Level 2'].obs;
  RxString selectedLevel = 'Choose level'.obs;
}
