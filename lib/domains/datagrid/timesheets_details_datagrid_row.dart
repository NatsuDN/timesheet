// By Admin vs By User

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timesheet/domains/timesheet_detail_sum.dart';
import 'package:timesheet/utils.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../components/data_grid/pluto_utils.dart';

class TimesheetsDetailsDatagirdInfo {
  final List<TimesheetsDetailsDatagridRow> rows;
  final TimesheetsDetailsSum? sum;
  static final List<String> statusList = [
    'Work',
    'Leave',
  ];
  static final List<PlutoColumn> plutoColumns = <PlutoColumn>[
    //   number = "Number",
    //   date = "Date",
    //   day = "Day",
    //   timeIn = "Time In",
    //   timeOut = "Time Out",
    //   project = "Project",
    //   activities = "Activities";

    textColummFixed('#', 'number', width: 40),
    textColummFixed('Date', 'date', width: 120, enableDropToResize: true),
    textColummFixed('Day', 'day', width: 60),
    selectionColumn('Status', 'status', statusList, width: 140),
    textColummFixed('Total Work', 'workingTime', width: 80),
    textColumn('Time In', 'timeIn',
        enableEditingMode: true, width: 80), //validate Time as well
    textColumn('Time Out', 'timeOut',
        enableEditingMode: true, width: 80), ////validate Time as well
    textColumn('Project', 'project',
        enableDropToResize: true, enableEditingMode: true, width: 200),
    textColumn('Activities', 'activities',
        width: 650, enableEditingMode: true, enableDropToResize: true),
  ];

  List<PlutoRow> get plutoRows {
    return rows
        .map((TimesheetsDetailsDatagridRow row) => row.plutoRow)
        .toList();
  }

  Map<String, dynamic> toJsonRecord(empId) {
    Map<String, dynamic> timesheetsMAP = {};
    for (var row in rows.where((TimesheetsDetailsDatagridRow row) =>
        ['Work(Updated)', 'Holiday', 'Leave'].contains(row.status))) {
      var status =
          row.status == 'Work(Updated)' ? 'RECORD' : row.status.toUpperCase();
      timesheetsMAP[row.date] = row.toJsonWithOutDate(status);
    }
    return {'empID': empId, 'timesheets_MAP': timesheetsMAP};
  }

  TimesheetsDetailsDatagirdInfo.clone(TimesheetsDetailsDatagirdInfo original)
      : this(rows: original.rows, sum: original.sum);
  TimesheetsDetailsDatagirdInfo({required this.rows, this.sum});
}

class TimesheetsDetailsDatagridRow {
  final String number,
      date,
      day,
      timeIn,
      timeOut,
      project,
      activities,
      status,
      totalWorkHour;
  TimesheetsDetailsDatagridRow(
      {required this.status,
      required this.totalWorkHour,
      required this.number,
      required this.date,
      required this.day,
      required this.timeIn,
      required this.timeOut,
      required this.project,
      required this.activities});

  TimesheetsDetailsDatagridRow.fromJsonByDateTime(Map<String, dynamic> json,
      {required String isoTime})
      : number = DateTime.parse(isoTime).day.toString(),
        date = getFormatDate(DateTime.parse(isoTime)),
        day = getWeekDay(DateTime.parse(isoTime)),
        totalWorkHour = json['workingTime']?.toString() ?? '',
        timeIn = json['timeIn']?.length > 5
            ? json['timeIn'].substring(0, 5)
            : json['timeIn'],
        timeOut = json['timeOut']?.length > 5
            ? json['timeOut'].substring(0, 5)
            : json['timeOut'],
        project = json['project'],
        status = json['dateStatus'] == 'OT'
            ? 'OT'
            : getCapitalized(json['dateStatus']),
        activities = json['activity'] ?? '-';

  // TimesheetsDetailsDatagridRow.mockUp()
  //     : number = "Test",
  //       date = "22/1/22",
  //       day = "Test",
  //       timeIn = "Test",
  //       timeOut = "Test",
  //       project = "Test",
  //       status = "Test",
  //       activities = "Test";
  TimesheetsDetailsDatagridRow.fromPlutoRow(PlutoRow plutoRow)
      : number = plutoRow.cells['number']!.value,
        date = plutoRow.cells['date']!.value,
        day = plutoRow.cells['day']!.value,
        totalWorkHour = plutoRow.cells['workingTime']!.value,
        timeIn = plutoRow.cells['timeIn']!.value,
        timeOut = plutoRow.cells['timeOut']!.value,
        project = plutoRow.cells['project']!.value,
        status = plutoRow.cells['status']!.value,
        activities = plutoRow.cells['activities']!.value;

  TimesheetsDetailsDatagridRow.unrecord(DateTime date)
      : number = date.day.toString(),
        date = getFormatDate(date),
        day = getWeekDay(date),
        totalWorkHour = '',
        timeIn = "10:00",
        timeOut = "18:00",
        project = "-",
        status = "Pending",
        activities = "-";
  TimesheetsDetailsDatagridRow.weekend(DateTime date)
      : number = date.day.toString(),
        date = getFormatDate(date),
        day = getWeekDay(date),
        totalWorkHour = '',
        timeIn = "",
        timeOut = "",
        project = "",
        status = "Holiday",
        activities = "Weekend";
  PlutoRow get plutoRow {
    return PlutoRow(cells: {
      'number': PlutoCell(value: number),
      'date': PlutoCell(value: date),
      'day': PlutoCell(value: day),
      'status': PlutoCell(
        value: status,
      ),
      'workingTime': PlutoCell(value: totalWorkHour),
      'timeIn': PlutoCell(value: timeIn),
      'timeOut': PlutoCell(value: timeOut),
      'project': PlutoCell(value: project),
      'activities': PlutoCell(value: activities),
    });
  }

  static List<TimesheetsDetailsDatagridRow>
      plutoRowsToTimesheetsDetailsDatagridRows(List<PlutoRow> plutoRows) {
    return plutoRows
        .map((PlutoRow row) => TimesheetsDetailsDatagridRow.fromPlutoRow(row))
        .toList();
  }

  static List<TimesheetsDetailsDatagridRow> getMonthLists(
    year,
    month,
  ) {
    DateTime start = DateTime(
      year,
      month,
    );
    DateTime end = DateTime(year, month == 12 ? 1 : month + 1, 0);
    List<DateTime> days = [];
    for (int i = 0; i <= end.difference(start).inDays; i++) {
      days.add(start.add(Duration(days: i)));
    }
    return days.map((DateTime date) {
      if (date.weekday == DateTime.saturday ||
          date.weekday == DateTime.sunday) {
        return TimesheetsDetailsDatagridRow.weekend(date);
      } else {
        return TimesheetsDetailsDatagridRow.unrecord(date);
      }
    }).toList();
  }

  @override
  String toString() {
    return 'Row: $number $status';
  }

  Map<String, dynamic> toJsonWithOutDate(String status) {
    return {
      'timeIn': timeIn.length == 5 ? '$timeIn:00' : timeIn,
      'timeOut': timeOut.length == 5 ? '$timeOut:00' : timeOut,
      'project': project,
      'activity': activities,
      'dateStatus': status,
      'workingTime': double.tryParse(totalWorkHour) ?? 0.0,
    };
  }
}
