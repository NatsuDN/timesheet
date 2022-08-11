import 'dart:collection';

import 'package:timesheet/utils.dart';
import 'package:table_calendar/table_calendar.dart';

class HolidayType {
  final String id;
  final String name;
  final Set<DateTime> holidayDateTimes;
  HolidayType({
    required this.id,
    required this.name,
    required this.holidayDateTimes,
  });

  List<String> get holidayDates {
    return holidayDateTimes
        .map((dateTime) => dateTime.toIso8601String())
        .toList();
  }

  HolidayType.empty()
      : id = '',
        name = '',
        holidayDateTimes = <DateTime>{};

  HolidayType.copy(HolidayType orginal)
      : id = orginal.id,
        name = orginal.name,
        holidayDateTimes = Set<DateTime>.from(orginal.holidayDateTimes);

  // HolidayType.fromJson(Map<String, dynamic> json)
  //     : name = json['name'],
  //       holidayDateTimes = Set<DateTime>.from(json['holidayDateTimes']
  //           .map((dateTime) => DateTime.parse(dateTime)));
  HolidayType.fromJsonId(Map<String, dynamic> json, {required this.id})
      : name = json['holidayName'],
        holidayDateTimes =
            Set<DateTime>.from(json['holiday_MAP'].entries.map((entry) {
          return DateTime.parse(entry.key + ' 00:00:00.000Z');
        }).toList());

  Map<String, dynamic> toJson() => {
        'holidayID': id,
        'holidayName': name,
        'holidayList':
            holidayDateTimes.map((date) => getFormatDate(date)).toList(),
      };
}
