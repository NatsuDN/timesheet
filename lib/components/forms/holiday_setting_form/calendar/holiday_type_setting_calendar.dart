// Copyright 2019 Aleksander Woźniak
// SPDX-License-Identifier: Apache-2.0

import 'dart:collection';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:timesheet/constants.dart';
import 'package:timesheet/domains/holiday_type.dart';
import 'package:table_calendar/table_calendar.dart';

import 'calendar_utils.dart';

class HolidayTypeSettingCalendar extends StatefulWidget {
  const HolidayTypeSettingCalendar({Key? key, required this.holidayType})
      : super(key: key);
  final HolidayType holidayType;
  @override
  State<HolidayTypeSettingCalendar> createState() =>
      _HolidayTypeSettingCalendarState();
}

class _HolidayTypeSettingCalendarState
    extends State<HolidayTypeSettingCalendar> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  late HolidayType _holidayType;
  @override
  void dispose() {
    super.dispose();
  }
  // Comapre OLd /New.

  // old [ 1 2 4 ]
  // new  [ 2 4 5 ]
  // send [ 1(Get Out) 5(Add) ]

  // @override
  // void didUpdateWidget(HolidayTypeSettingCalendar oldWidget) {
  //   super.didUpdateWidget(oldWidget);
  //   log('Update Widget');
  //   log(widget.holidayType.name);
  //   // setState(() {
  //   //   _holidayDateTimes = widget.holidayDateTimes;
  //   // });
  // }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _focusedDay = focusedDay;
      if (_holidayType.holidayDateTimes.contains(selectedDay)) {
        _holidayType.holidayDateTimes.remove(selectedDay);
      } else {
        _holidayType.holidayDateTimes.add(selectedDay);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _holidayType = widget.holidayType;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TableCalendar(
          calendarStyle: CalendarStyle(
              todayDecoration: BoxDecoration(
                  color: kThemeColor.withOpacity(0.5), shape: BoxShape.circle),
              selectedDecoration:
                  BoxDecoration(color: kThemeColor, shape: BoxShape.circle),
              rangeHighlightColor: kThemeColor),
          firstDay: kFirstDay,
          lastDay: kLastDay,
          focusedDay: _focusedDay,
          calendarFormat: _calendarFormat,
          startingDayOfWeek: StartingDayOfWeek.sunday,
          selectedDayPredicate: (day) {
            // Use values from Set to mark multiple days as selected
            return _holidayType.holidayDateTimes.contains(day);
          },
          onDaySelected: _onDaySelected,
          onFormatChanged: (format) {
            if (_calendarFormat != format) {
              setState(() {
                _calendarFormat = format;
              });
            }
          },
          onPageChanged: (focusedDay) {
            _focusedDay = focusedDay;
          },
        ),
        // ElevatedButton(
        //   child: Text('Clear selection'),
        //   onPressed: () {
        //     setState(() {
        //       _holidayDateTimes.clear();
        //     });
        //   },
        // ),
      ],
    );
  }
}
