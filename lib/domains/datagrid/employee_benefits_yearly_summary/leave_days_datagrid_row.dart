import 'package:timesheet/domains/datagrid/employee_benefits_yearly_summary/employee_benefits_yearly_summary_datagrid_row.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../../components/data_grid/pluto_utils.dart';

class LeaveDaysDatagridInfo {
  final List<LeaveDaysDatagridRow> rows;
  static final List<PlutoColumn> plutoColumns = <PlutoColumn>[
    // empCode = "empCode",
    // nickName = "Nickname",
    // total = "Total",
    // jan = "Jan",
    // feb = "Feb",
    // mar = "Mar",
    // apr = "Apr",
    // may = "May",
    // jun = "Jun",
    // jul = "Jul",
    // aug = "Aug",
    // sep = "Sep",
    // oct = "Oct",
    // nov = "Nov",
    // dec = "Dec",
    textColummFixed('EmpId', 'empId', hide: true),
    textColummFixed('Emp Code', 'empCode'),
    textColummFixed('Nickname', 'nickName'),
    textColummFixed('Total', 'total'),
    textColummFixed('Jan', 'jan'),
    textColummFixed('Feb', 'feb'),
    textColummFixed('Mar', 'mar'),
    textColummFixed('Apr', 'apr'),
    textColummFixed('May', 'may'),
    textColummFixed('Jun', 'jun'),
    textColummFixed('Jul', 'jul'),
    textColummFixed('Aug', 'aug'),
    textColummFixed('Sep', 'sep'),
    textColummFixed('Oct', 'oct'),
    textColummFixed('Nov', 'nov'),
    textColummFixed('Dec', 'dec'),
  ];
  LeaveDaysDatagridInfo({required this.rows});
  List<PlutoRow> get plutoRows {
    return rows.map((LeaveDaysDatagridRow row) => row.plutoRow).toList();
  }
}

class LeaveDaysDatagridRow extends EmployeeBenefitsYearlySummary {
  LeaveDaysDatagridRow(
      {required super.empId,
      required super.empCode,
      required super.nickName,
      required super.total,
      required super.jan,
      required super.feb,
      required super.mar,
      required super.apr,
      required super.may,
      required super.jun,
      required super.jul,
      required super.aug,
      required super.sep,
      required super.oct,
      required super.nov,
      required super.dec});

  LeaveDaysDatagridRow.mockUp() : super.mockUp();
  LeaveDaysDatagridRow.fromJsonByEmpId(Map<String, dynamic> json,
      {required String empId})
      : super.fromJsonByEmpId(json, empId: empId);
}
