import 'package:doctor_on_call/utils/app_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FileUtils {
  FileUtils._();

  static final currentDate = DateTime.now();
  static final yesterdayDate = DateTime.now().subtract(const Duration(days: 1));
  static final lastWeekDate = DateTime.now().subtract(const Duration(days: 6));
  static final lastMonthDate =
      DateTime.now().subtract(const Duration(days: 29));

  static Future<DateTime?> pickDate(BuildContext context) async {
    final DateTime? selectedTime = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(3000),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData(
              primaryColor: AppColor.primaryColor,
              colorScheme: ColorScheme.light(primary: AppColor.primaryColor),
              buttonTheme:
                  const ButtonThemeData(textTheme: ButtonTextTheme.primary),
            ),
            child: child ?? const SizedBox.shrink(),
          );
        });
    if (selectedTime != null) {
      return selectedTime;
    } else {
      return null;
    }
  }

  static pickTime(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData(
            primaryColor: AppColor.primaryColor,
            colorScheme:
                const ColorScheme.light(primary: AppColor.primaryColor),
            buttonTheme:
                const ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
            child: child ?? const SizedBox.shrink(),
          ),
        );
      },
    );
    if (timeOfDay != null) {
      if (timeOfDay.hourOfPeriod < 10) {
        if (timeOfDay.minute < 10) {
          // pickTime =
          "0${timeOfDay.hourOfPeriod}:0${timeOfDay.minute} ${timeOfDay.period.name.toUpperCase()}";
        } else {
          // pickTime =
          "0${timeOfDay.hourOfPeriod}:${timeOfDay.minute} ${timeOfDay.period.name.toUpperCase()}";
        }
      } else {
        if (timeOfDay.minute < 10) {
          // pickTime =
          "${timeOfDay.hourOfPeriod}:0${timeOfDay.minute} ${timeOfDay.period.name.toUpperCase()}";
        } else {
          // pickTime =
          "${timeOfDay.hourOfPeriod}:${timeOfDay.minute} ${timeOfDay.period.name.toUpperCase()}";
        }
      }
      return timeOfDay;
    } else {
      return null;
    }
  }

  static Future<DateTimeRange?> pickDateRange(BuildContext context) async {
    DateTimeRange initialDate = DateTimeRange(
        start: DateTime.now().subtract(
          const Duration(days: 0),
        ),
        end: DateTime.now().add(const Duration(days: 5)));

    DateTimeRange? newDateTimeRange = await showDateRangePicker(
        context: context,
        initialDateRange: initialDate,
        firstDate: DateTime(2020),
        lastDate: DateTime.now().add(const Duration(days: 10)),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData(
              primaryColor: AppColor.primaryColor,
              colorScheme:
                  const ColorScheme.light(primary: AppColor.primaryColor),
              buttonTheme:
                  const ButtonThemeData(textTheme: ButtonTextTheme.primary),
            ),
            child: child ?? const SizedBox.shrink(),
          );
        });

    return newDateTimeRange;
  }

  static getFormatDate(String date) {
    var inputDate = DateTime.parse(date);
    var outputFormat = DateFormat('MMM dd, yyyy');
    var newDate = outputFormat.format(inputDate);
    return newDate;
  }
}
