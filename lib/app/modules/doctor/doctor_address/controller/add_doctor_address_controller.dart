import 'package:daroon_doctor/global/constants/app_tokens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_address/controller/doctor_address_controller.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_address/model/office_type_model.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_home/controller/doctor_home_controller.dart';
import 'package:daroon_doctor/global/widgets/toast_message.dart';
import 'package:daroon_doctor/services/api.dart';
import 'package:intl/intl.dart';

class AddDoctorAddressController extends GetxController {
  RxBool isAppBarOpen = false.obs;
  RxInt slectedOffice = 0.obs;

  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController feeClinic = TextEditingController();
  TextEditingController feeMessage = TextEditingController();
  TextEditingController feeCall = TextEditingController();
  TextEditingController feeVideo = TextEditingController();

  TextEditingController streetNumber = TextEditingController();
  TextEditingController townName = TextEditingController();
  TextEditingController cityName = TextEditingController();
  TextEditingController countryName = TextEditingController();

  ///
  DateTime selectedDayTimeStamp = DateTime.now();
//// Loader Variable.
  final _processing = false.obs;
  bool get processing => _processing.value;

  RxBool isStartWithTime = false.obs;
  Rx<TimeOfDay> startWithTime = const TimeOfDay(hour: 0, minute: 0).obs;

  RxBool isEndWithTime = false.obs;
  Rx<TimeOfDay> endWithTime = const TimeOfDay(hour: 0, minute: 0).obs;

  RxDouble long = 0.0.obs;
  RxDouble lat = 0.0.obs;

  ///
  RxBool istimeDuration = false.obs;
  Rx<Duration> timeDuration = const Duration().obs;

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

  Future<void> registerOffice(BuildContext context) async {
    try {
      _processing.value = true;
      FocusManager.instance.primaryFocus?.unfocus();

      final response = await ApiService.postWithHeader(
          userToken: {
            'Content-Type': 'application/json',
            'Authorization':
                "Bearer ${Get.find<DoctorHomeController>().userModel.value!.token!}",
          },
          endPoint: '${AppTokens.apiURl}/office',
          body: {
            "title": title.text,
            // "doctorId":
            //     Get.find<DoctorHomeController>().userModel.value!.user!.id!,
            "description": description.text,
            "types-of-offices":
                officeTypeList[slectedOffice.value].title.toLowerCase(),
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
            "typeOfCurrency": "66ea99e6c7a88efd35724531",

            // 'typeOfOffice':'dd',
            "phoneNumbers": ["07500132", "075016132"],
            "address": {
              "coordinate": {
                "latitude": "${lat.value}",
                "longitude": "${long.value}",
              },
              "country": "66eb276fc7a88efd35724dba",
              "city": cityName.text,
              "town": townName.text,
              "street": streetNumber.text,
              "typeOfOffice": "66e04d4b15b32e335a665792",
            }
          });

      if (response != null) {
        if (response.statusCode == 201 || response.statusCode == 200) {
          showToastMessage(
              message: "Successfully register.",
              context: context,
              color: const Color(0xff5BA66B),
              icon: Icons.check);
          // final jsonData = jsonDecode(response.body)['data'];

          Get.find<DoctorAddressController>().getDoctorOfficeAddress();
          // Get.find<DoctorAddressController>()
          //     .officeAddressModelList
          //     .add(OfficeAddreesModel.fromJson(jsonData));
          // print(jsonData);
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
