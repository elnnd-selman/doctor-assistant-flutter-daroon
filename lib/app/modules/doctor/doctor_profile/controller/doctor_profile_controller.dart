import 'package:get/get.dart';

class DoctorProfileController extends GetxController {
  final _selectedTab = 0.obs;
  int get selectedTab => _selectedTab.value;

  void selectTab(int value) {
    _selectedTab.value = value;
  }
}
