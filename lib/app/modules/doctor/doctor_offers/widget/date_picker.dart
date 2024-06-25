import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hezr/app/modules/doctor/doctor_offers/widget/date_bar.dart';
import 'package:hezr/global/constants/app_colors.dart';
import 'package:hezr/global/utils/app_text_style.dart';
import 'package:hezr/global/utils/widget_spacing.dart';
import 'package:hezr/global/widgets/common_button.dart';

class DcotorOfferDateTime extends StatefulWidget {
  const DcotorOfferDateTime({
    super.key,
  });

  @override
  // ignore: library_private_types_in_public_api
  _DcotorOfferDateTimeState createState() => _DcotorOfferDateTimeState();
}

class _DcotorOfferDateTimeState extends State<DcotorOfferDateTime> {
  final _lastMidnight = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  ).millisecondsSinceEpoch;

  DateTime selectedDayTimeStamp = DateTime.now();
//
  DateTime timeStamp = DateTime.now();

  @override
  void initState() {
    super.initState();
    selectedDayTimeStamp = DateTime.now();

    // if (widget.timestamp == 0) {
    //   selectedDayTimeStamp = DateTime.now();
    // } else {
    //   selectedDayTimeStamp =
    //       DateTime.fromMillisecondsSinceEpoch(widget.timestamp);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(Get.context!)
          .copyWith(textScaler: const TextScaler.linear(1)),
      child: Container(
        height: MediaQuery.of(Get.context!).size.height * 0.7,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                margin: const EdgeInsets.only(top: 12),
                width: MediaQuery.of(Get.context!).size.width * 0.25,
                height: 5,
                decoration: BoxDecoration(
                  color: AppColors.blackBGColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            24.verticalSpace,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Selected Time',
                    style: AppTextStyles.semiBold.copyWith(fontSize: 21),
                  ),
                  // 6.verticalSpace,
                  // Text(
                  //   'offer Time',
                  //   style: AppTextStyles.medium.copyWith(
                  //     fontSize: 15,
                  //     color: AppColors.lighttextColor,
                  //   ),
                  // ),
                ],
              ),
            ),

            20.verticalSpace,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: CustomCalender(
                fontSize: 14,
                selectedCalenderData: selectedDayTimeStamp,
                onDaySelected: (date) {
                  setState(() {
                    selectedDayTimeStamp = date;
                  });
                },
              ),
            ),
            // DatePickingBar(
            //   initialValue: selectedDayTimeStamp,
            //   onDayChange: (value) {
            //     setState(() {
            //       selectedDayTimeStamp = value;
            //     });
            //   },
            //   onWeekChange: (value) {},
            //   futureOnly: widget.workoutPurpose == WorkoutPurpose.schedule ||
            //       widget.workoutPurpose == WorkoutPurpose.edit,
            //   pastOnly: widget.workoutPurpose == WorkoutPurpose.markAsComplete,
            //   dateBackgroundColor: AppColors.whiteBGColor,
            // ),
            const Expanded(child: SizedBox()),
            SizedBox(
              height: MediaQuery.of(Get.context!).size.height * 0.25,
              child:
                  selectedDayTimeStamp.millisecondsSinceEpoch == _lastMidnight
                      ? CupertinoTheme(
                          data: CupertinoThemeData(
                            brightness: Brightness.light,
                            textTheme: CupertinoTextThemeData(
                              dateTimePickerTextStyle: selectedStyle,
                            ),
                          ),
                          child: CupertinoDatePicker(
                            initialDateTime: selectedDayTimeStamp,
                            minimumDate: DateTime.now(),
                            maximumDate: DateTime.now(),
                            onDateTimeChanged: (value) {
                              timeStamp = value;
                              HapticFeedback.lightImpact();
                            },
                            mode: CupertinoDatePickerMode.time,
                          ),
                        )
                      : CupertinoTheme(
                          data: CupertinoThemeData(
                            brightness: Brightness.light,
                            textTheme: CupertinoTextThemeData(
                              dateTimePickerTextStyle: selectedStyle,
                            ),
                          ),
                          child: CupertinoDatePicker(
                            initialDateTime: selectedDayTimeStamp,
                            onDateTimeChanged: (value) {
                              timeStamp = value;
                            },
                            mode: CupertinoDatePickerMode.time,
                          ),
                        ),
            ),
            const Expanded(child: SizedBox()),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // if (widget.workoutPurpose == WorkoutPurpose.edit)
                //   8.horizontalSpace,
                SizedBox(
                  width: MediaQuery.of(Get.context!).size.width * 0.9,
                  child: CommonButton(
                    ontap: () {
                      Get.back();
                      // final scheduledTime = DateTime(
                      //   selectedDayTimeStamp.year,
                      //   selectedDayTimeStamp.month,
                      //   selectedDayTimeStamp.day,
                      //   _timeStamp.hour,
                      //   _timeStamp.minute,
                      // );
                      // Get.back(result: Timestamp.fromDate(scheduledTime));
                      // NotificationService.scheduleWorkoutNotification(
                      //   scheduledTime.millisecondsSinceEpoch,
                      // );

                      // _scheduleAlert();
                    },
                    name: 'Save',
                  ),
                ),
              ],
            ),
            10.verticalSpace,
          ],
        ),
      ),
    );
  }
}

final selectedStyle = AppTextStyles.semiBold.copyWith(
  fontSize: 22,
);
final unSelectedStyle = AppTextStyles.semiBold.copyWith(
  fontSize: 18,
);
