import 'dart:convert';
import 'package:daroon_doctor/app/modules/doctor/doctor_address/controller/doctor_address_controller.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_address/model/doctor_office_address_model.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_home/controller/doctor_home_controller.dart';
import 'package:daroon_doctor/global/widgets/toast_message.dart';
import 'package:daroon_doctor/services/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class EditDoctorScheduleController extends GetxController {
  TextEditingController feeClinic = TextEditingController();
  TextEditingController feeMessage = TextEditingController();
  TextEditingController feeCall = TextEditingController();
  TextEditingController feeVideo = TextEditingController();

  //
  final _processing = false.obs;
  bool get processing => _processing.value;
  RxBool istimeDuration = false.obs;
  Rx<Duration> timeDuration = const Duration().obs;

  RxBool isStartWithTime = false.obs;
  Rx<TimeOfDay> startWithTime = const TimeOfDay(hour: 0, minute: 0).obs;

  RxBool isEndWithTime = false.obs;
  Rx<TimeOfDay> endWithTime = const TimeOfDay(hour: 0, minute: 0).obs;

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

  RxList selectedWeekDays = [].obs;

  ////
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

  setScheduleAdress(OfficeAddreesModel office) {
    feeCall.text = office.fee!.feeCall!.toString();
    feeMessage.text = office.fee!.feeMessage!.toString();
    feeClinic.text = office.fee!.feeClinic!.toString();
    feeVideo.text = office.fee!.feeVideoCall!.toString();

    selectedWeekDays.value = office.daysOpen!;

    isEndWithTime.value = true;

    List<String> parts = office.endTime!.split(':');

    String hours = parts[0];
    String minutes = parts[1];
    endWithTime.value =
        TimeOfDay(hour: int.parse(hours), minute: int.parse(minutes));

    isStartWithTime.value = true;

    List<String> partStart = office.startTime!.split(':');

    String hourStart = partStart[0];
    String minuteStart = partStart[1];
    endWithTime.value =
        TimeOfDay(hour: int.parse(hourStart), minute: int.parse(minuteStart));
    istimeDuration.value = true;
    timeDuration.value = Duration(minutes: office.appointmentDuration!);
  }

  Future<void> updateOffice({
    required BuildContext context,
    required OfficeAddreesModel office,
  }) async {
    try {
      _processing.value = true;
      FocusManager.instance.primaryFocus?.unfocus();

      final response = await ApiService.putWithHeader(
          userToken: {
            'Content-Type': 'application/json',
            "Authorization":
                "Bearer ${Get.find<DoctorHomeController>().userModel.value!.token!}",
          },
          endPoint:
              'https://development-api.daroon.krd/api/office/update-my-office/${office.id}',
          body: {
            "title": office.title,
            "doctorId":
                Get.find<DoctorHomeController>().userModel.value!.user!.id!,
            "description": office.description!,
            "typeOfOffice": office.typeOfOffice,
            "daysOpen": selectedWeekDays,
            "startTime":
                "${startWithTime.value.hour.toString()}:${startWithTime.value.minute.toString()}",
            "endTime":
                "${endWithTime.value.hour.toString()}:${endWithTime.value.minute.toString()}",
            "appointmentDuration": timeDuration.value.inMinutes.toString(),
            "appointmentTimeType": "hour",
            "fee": {
              "feeClinic": feeClinic.text,
              "feeMessage": feeMessage.text,
              "feeCall": feeCall.text,
              "feeVideoCall": feeVideo.text
            },
            "typeOfCurrency": "usd",
            "phoneNumbers": ["07500132", "075016132"],
            "address": {
              "coordinate": {
                "latitude": "${office.address!.coordinate!.latitude!}",
                "longitude": "${office.address!.coordinate!.longitude!}",
              },
              "country": office.address!.country!,
              "city": office.address!.city!,
              "town": office.address!.town!,
              "street": office.address!.street!
            }
          });

      if (response != null) {
        if (response.statusCode == 201 || response.statusCode == 200) {
          showToastMessage(
              message: "Successfully register.",
              context: context,
              color: const Color(0xff5BA66B),
              icon: Icons.check);
          final jsonData = jsonDecode(response.body)['data'];
          Get.find<DoctorAddressController>()
              .officeAddressModelList
              .removeWhere((item) => item.id == office.id);
          Get.find<DoctorAddressController>()
              .officeAddressModelList
              .add(OfficeAddreesModel.fromJson(jsonData));
          print(jsonData);
          Get.back();
          Get.back();

          _processing.value = false;
        } else {
          _processing.value = false;
          showToastMessage(
              message: response.body,
              context: context,
              color: const Color(0xffEC1C24),
              icon: Icons.close);
        }
      } else {
        _processing.value = false;
        showToastMessage(
            message: response!.body,
            context: context,
            color: const Color(0xffEC1C24),
            icon: Icons.close);
      }
    } catch (e) {
      _processing.value = false;
      showToastMessage(
          message: "Issue ${e.toString()}",
          context: context,
          color: const Color(0xffEC1C24),
          icon: Icons.close);
    }
  }
}
