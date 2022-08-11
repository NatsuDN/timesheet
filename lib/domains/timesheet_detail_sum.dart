import 'package:timesheet/domains/datagrid/timesheets_details_datagrid_row.dart';

// {
//   "totalLeave": 0.5,
//   "totalHalfday": 1,
//   "totalWork": 27,
//   "totalHoliday": 2,
//   "totalOT": 1
// }
class TimesheetsDetailsSum {
  final double totalLeave, totalWork, totalHoliday, totalOT;
  TimesheetsDetailsSum({
    required this.totalLeave,
    required this.totalWork,
    required this.totalHoliday,
    required this.totalOT,
  });

  factory TimesheetsDetailsSum.fromJson(Map<String, dynamic> json) {
    return TimesheetsDetailsSum(
      totalLeave: json['totalLeave'] as double,
      totalWork: json['totalWork'] as double,
      totalHoliday: json['totalHoliday'] as double,
      totalOT: json['totalOT'] as double,
    );
  }
  TimesheetsDetailsSum.mockUp()
      : totalLeave = 0.5,
        totalWork = 27,
        totalHoliday = 2,
        totalOT = 1;
  TimesheetsDetailsSum.empty()
      : totalLeave = 0,
        totalWork = 0,
        totalHoliday = 0,
        totalOT = 0;
}
