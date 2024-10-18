import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;

class DoctorDetailController extends GetxController {
  CustomPopupMenuController customPopupMenuController =
      CustomPopupMenuController();

  RxList<String> menuList = [
    "Delete",
  ].obs;
  RxList<String> weekDaysList = [
    "Sun",
    "Mon",
    "Tue",
    "Wed",
    "Thu",
    "Fri",
    "Sat",
  ].obs;

  RxList<String> weekDaysListFull = [
    "sunday",
    "monday",
    "tuesday",
    "wednesday",
    "thursday",
    "friday",
    "saturday"
  ].obs;
  String convertTo12HourFormat(int hours, int minutes) {
    DateTime currentTime = DateTime.now();

    // Create DateTime object with specified hours and minutes
    DateTime parsedTime = DateTime(
      currentTime.year,
      currentTime.month,
      currentTime.day,
      hours,
      minutes,
    );

    // Format the parsed DateTime into 12-hour format string
    String time12 = DateFormat('h:mm a').format(parsedTime);

    return time12;
  }

  String convert24HourTo12Hour(String time24) {
    // Parse the input time string to a DateTime object
    DateTime dateTime = DateFormat.Hm().parse(time24);

    // Format the DateTime object to a 12-hour time format
    String formattedTime = DateFormat('h:mm a').format(dateTime);

    return formattedTime;
  }

  int separeteHours(int totalMinutes) {
    int hours = totalMinutes ~/ 60;
    return hours;
  }

  int separeteMinutes(int totalMinutes) {
    int minutes = totalMinutes % 60;

    return minutes;
  }

  Uint8List markerIcon = Uint8List(8);
  RxBool isGoogleMapLoading = false.obs;
  setGoogleMapIcon() async {
    isGoogleMapLoading.value = true;
    final Uint8List icons =
        await getBytesFromAsset('assets/icons_png/location_icon.png', 80);
    markerIcon = icons;
    isGoogleMapLoading.value = false;
    update();
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }
}
