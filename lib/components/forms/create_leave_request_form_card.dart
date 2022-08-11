import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timesheet/components/forms/layout/drag_and_drop_field.dart';
import 'package:timesheet/components/forms/layout/primary_form_card.dart';
import 'package:timesheet/utils.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../providers/auth_provider.dart';
import '../../services/employees_data_controller.dart';
import 'holiday_setting_form/calendar/calendar_utils.dart';
import 'layout/primary_dropdown.dart';
import 'layout/primary_textformfield.dart';

class CreateLeaveRequestFormCard extends ConsumerStatefulWidget {
  const CreateLeaveRequestFormCard({Key? key}) : super(key: key);

  @override
  _CreateLeaveRequestFormCardState createState() =>
      _CreateLeaveRequestFormCardState();
}

class _CreateLeaveRequestFormCardState extends ConsumerState<CreateLeaveRequestFormCard>  {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _noteCtrl = TextEditingController();
  final TextEditingController _leaveTypeCtrl = TextEditingController();
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
      .toggledOn;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  @override
  void initState() {
    super.initState();
  }

  _onSubmit(ref, {required BuildContext context}) async {
    if (_formKey.currentState!.validate()) {
      if (await createLeaveRequest(
          ref.watch(authControllerProvider).user!.employee.empCode,
          getFormatDate(_rangeStart!),
          _rangeEnd == null? getFormatDate(_rangeStart!) : getFormatDate(_rangeEnd!),
          _leaveTypeCtrl.text.toUpperCase(),
          _noteCtrl.text,
          context: context)) {
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return PrimaryFormCard(
        showBorder: false,
        formKey: _formKey,
        title: 'Leave Request',
        onSubmit: () {
          _onSubmit(ref, context: context);
        },
        submitLabel: 'Create',
        children: [
          TableCalendar(
            firstDay: kFirstDay,
            lastDay: kLastDay,
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            rangeStartDay: _rangeStart,
            rangeEndDay: _rangeEnd,
            calendarFormat: _calendarFormat,
            rangeSelectionMode: _rangeSelectionMode,
            onDaySelected: (selectedDay, focusedDay) {
              if (!isSameDay(_selectedDay, selectedDay)) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                  _rangeStart = selectedDay; // Important to clean those
                  _rangeEnd = selectedDay;
                  _rangeSelectionMode = RangeSelectionMode.toggledOff;
                });
              }
            },
            onRangeSelected: (start, end, focusedDay) {
              setState(() {
                _selectedDay = null;
                _focusedDay = focusedDay;
                _rangeStart = start;
                _rangeEnd = end;
                _rangeSelectionMode = RangeSelectionMode.toggledOn;
              });
            },
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
          PrimaryDropDown(
            title: 'Leave Type',
            defaultValue: 'Sick',
            items: const ['Sick', 'Business', 'Vacation'],
            onChanged: (value) {
              _leaveTypeCtrl.text = value;
            },
          ),
          PrimaryTextFormField(
            title: 'Note',
            controller: _noteCtrl,
            validator: (String? str) {
              if (str != null && str.isEmpty) {
                return "โปรดระบุรายละเอียด";
              }
              return null;
            },
          ),
        ]
    );
  }
}
