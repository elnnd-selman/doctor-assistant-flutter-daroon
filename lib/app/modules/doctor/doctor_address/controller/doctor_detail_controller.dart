import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DoctorDetailController extends GetxController {
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
}
