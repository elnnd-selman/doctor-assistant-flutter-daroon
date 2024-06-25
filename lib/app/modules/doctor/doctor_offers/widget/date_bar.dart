import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hezr/global/constants/app_colors.dart';
import 'package:hezr/global/utils/app_text_style.dart';
import 'package:table_calendar/table_calendar.dart';

// ignore: must_be_immutable
class CustomCalender extends StatelessWidget {
  CustomCalender(
      {super.key,
      required this.selectedCalenderData,
      this.fontSize = 20,
      required this.onDaySelected});
  DateTime selectedCalenderData;
  final Function onDaySelected;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      firstDay: DateTime.utc(2024, 1, 1),
      lastDay: DateTime.utc(2034, 3, 14),
      focusedDay: selectedCalenderData,
      calendarFormat: CalendarFormat.week,
      pageJumpingEnabled: true,
      pageAnimationEnabled: true,
      weekendDays: const [],
      selectedDayPredicate: (day) => day == selectedCalenderData,
      onDaySelected: (selectedDay, focusedDay) => onDaySelected(selectedDay),
      calendarBuilders: CalendarBuilders(
        selectedBuilder: (context, day, focusedDay) => _selectedBuilder(day),
        todayBuilder: (context, day, focusedDay) =>
            selectedCalenderData.day == day.day
                ? _selectedBuilder(day)
                : Center(
                    child: Text(
                      '${day.day}',
                      style: AppTextStyles.medium.copyWith(
                        fontSize: 14,
                      ),
                    ),
                  ),
      ),
      startingDayOfWeek: StartingDayOfWeek.monday,
      headerStyle: HeaderStyle(
        leftChevronVisible: false,
        rightChevronVisible: false,
        formatButtonShowsNext: false,
        headerPadding: const EdgeInsets.only(
          left: 10,
          bottom: 10,
        ),
        formatButtonVisible: false,
        titleTextStyle: AppTextStyles.semiBold.copyWith(
          color: Colors.black,
          fontSize: fontSize,
          letterSpacing: -0.2,
        ),
      ),
      daysOfWeekStyle: DaysOfWeekStyle(
        weekendStyle: AppTextStyles.medium.copyWith(
          color: Colors.black,
        ),
        weekdayStyle: AppTextStyles.semiBold.copyWith(
          color: Colors.black,
        ),
      ),
    );
  }

  Center _selectedBuilder(DateTime day) {
    return Center(
      child: Container(
        height: MediaQuery.of(Get.context!).size.width * 0.1,
        width: MediaQuery.of(Get.context!).size.width * 0.1,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: AppColors.primaryColor,
        ),
        child: Center(
          child: Text(
            day.day.toString(),
            style: AppTextStyles.medium.copyWith(
              fontSize: 14,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
