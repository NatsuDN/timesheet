// By Admin vs By User

import 'package:timesheet/constants.dart';
import 'package:timesheet/domains/datagrid/datagrid_utils.dart';
import 'package:timesheet/utils.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../components/data_grid/pluto_utils.dart';

class TimesheetsDatagridInfo {
  final List<TimeSheetsDatagridRow> rows;
  static final List<String> statusList = [
    'Approve',
    'Reject',
  ];
  static final List<PlutoColumn> plutoColumns = <PlutoColumn>[
    textColummFixed('EmpId', 'empId', hide: true),
    textColummFixed('EmpCode', 'empCode'),
    textColummFixed('Nickname', 'nickName'),
    textColummFixed('Holiday Type', 'holidayType'),
    selectionColumn('Status', 'status', statusList, width: 140),
    textColummFixed('Total Leave Days', 'totalLeaveDays'),
    textColummFixed('Total Overtime', 'totalOverTime'),
    textColummFixed('Total Working Days', 'totalWorkingDays'),
    textColummFixed(
      'Details',
      'details',
    ),
    selectionColumn('test', 'test', ['a', 'b', 'c'], width: 140),
  ];

  List<PlutoRow> get plutoRows {
    return rows.map((TimeSheetsDatagridRow row) => row.plutoRow).toList();
  }

  TimesheetsDatagridInfo({required this.rows});
}

class TimeSheetsDatagridRow {
  final String empId,
      empCode,
      nickName,
      holidayType,
      status,
      totalLeaveDays,
      totalOverTime,
      totalWorkingDays,
      details;
  TimeSheetsDatagridRow(
      {required this.empId,
      required this.empCode,
      required this.nickName,
      required this.holidayType,
      required this.status,
      required this.totalLeaveDays,
      required this.totalOverTime,
      required this.totalWorkingDays,
      required this.details});

  factory TimeSheetsDatagridRow.fromJsonByEmpId(Map<String, dynamic> json,
      {required String empId}) {
    return TimeSheetsDatagridRow(
        empId: empId,
        empCode: json['empCode'] ?? 'error',
        nickName: json['nickName'] ?? 'error',
        holidayType: json['holidayName'] ?? 'error',
        status: getCapitalized(json['timesheetsStatus'] ?? 'error'),
        totalLeaveDays: json['leaveUse']?.toString() ?? 'error',
        totalOverTime: json['totalOT']?.toString() ?? 'error',
        totalWorkingDays: json['totalWork']?.toString() ?? 'error',
        details: '📄 View');
  }

  TimeSheetsDatagridRow.mockUp()
      : empId = 'Test',
        empCode = "Test",
        nickName = "Test",
        holidayType = "Test",
        status = "Test",
        totalLeaveDays = "Test",
        totalOverTime = "Test",
        totalWorkingDays = "Test",
        details = "Test";
  PlutoRow get plutoRow {
    return PlutoRow(cells: {
      'empId': PlutoCell(value: empId),
      'empCode': PlutoCell(value: empCode),
      'nickName': PlutoCell(value: nickName),
      'holidayType': PlutoCell(value: holidayType),
      'status': PlutoCell(value: status),
      'totalLeaveDays': PlutoCell(value: totalLeaveDays),
      'totalOverTime': PlutoCell(value: totalOverTime),
      'totalWorkingDays': PlutoCell(value: totalWorkingDays),
      'details': PlutoCell(value: details),
      'test': PlutoCell(value: 'test'),
    });
  }
}
