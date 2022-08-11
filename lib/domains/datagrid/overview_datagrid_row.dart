import 'package:timesheet/components/data_grid/overview_datagrid.dart';
import 'package:timesheet/constants.dart';
import 'package:timesheet/domains/datagrid/datagrid_utils.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../components/data_grid/pluto_utils.dart';

class OverviewDatagridInfo {
  final List<OverviewDatagridRow> rows;

  static final List<PlutoColumn> plutoColumns = <PlutoColumn>[
    textColummFixed('EmpId', 'empId', hide: true),
    textColummFixed('Emp Code', 'empCode'),
    textColummFixed('Full Name', 'fullName',
        width: 130, textAlign: PlutoColumnTextAlign.start),
    textColummFixed('Nickname', 'nickName'),
    textColummFixed('Quota', 'leaveDayEntitlement'),
    textColummFixed('Used', 'totalLeaveDaysUsed'),
    textColummFixed('Remaining', 'totalLeaveDaysRemaining'),
    textColummFixed('Quota', 'medicalFeesEntitlement'),
    textColummFixed('Used', 'totalMedicalFeesUsed'),
    textColummFixed('Remaining', 'totalMedicalFeesRemaining'),
    textColummFixed('End Contract', 'endContract'),
    textColummFixed('Profile', 'profile'),
    textColummFixed('Actions', 'actions')
  ];

  static final List<PlutoColumnGroup> plutoColumnGroups = <PlutoColumnGroup>[
    PlutoColumnGroup(
      backgroundColor: kThemeSecondaryBackgroundColor,
      title: 'Info',
      fields: ['empCode', 'fullName', 'nickName'],
    ),
    PlutoColumnGroup(
      backgroundColor: kThemeSecondaryBackgroundColor,
      title: 'Time Off',
      fields: [
        'leaveDayEntitlement',
        'totalLeaveDaysUsed',
        'totalLeaveDaysRemaining'
      ],
    ),
    PlutoColumnGroup(
      backgroundColor: kThemeSecondaryBackgroundColor,
      title: 'Medical Fess',
      fields: [
        'medicalFeesEntitlement',
        'totalMedicalFeesUsed',
        'totalMedicalFeesRemaining'
      ],
    ),
  ];
  List<PlutoRow> get plutoRows {
    return rows.map((OverviewDatagridRow row) => row.plutoRow).toList();
  }

  OverviewDatagridInfo({required this.rows});
}

class OverviewDatagridRow {
  final String empId,
      empCode,
      fullName,
      nickName,
      leaveDayEntitlement,
      medicalFeesEntitlement,
      totalLeaveDaysUsed,
      totalMedicalFeesUsed,
      totalLeaveDaysRemaining,
      totalMedicalFeesRemaining,
      endContract,
      profile,
      actions;
  OverviewDatagridRow(
      {required this.empId,
      required this.empCode,
      required this.fullName,
      required this.nickName,
      required this.leaveDayEntitlement,
      required this.medicalFeesEntitlement,
      required this.totalLeaveDaysUsed,
      required this.totalMedicalFeesUsed,
      required this.totalLeaveDaysRemaining,
      required this.totalMedicalFeesRemaining,
      required this.endContract,
      required this.profile,
      required this.actions});

  factory OverviewDatagridRow.fromJsonByEmpId(Map<String, dynamic> json,
      {required String empId}) {
    return OverviewDatagridRow(
        empId: empId,
        empCode: json['empCode'] ?? 'error',
        fullName: '${json['firstName']} ${json['lastName']}',
        nickName: json['nickName'],
        leaveDayEntitlement: json['leaveLimit']?.toString() ?? '0',
        medicalFeesEntitlement: json['medFeeLimit']?.toString() ?? '0',
        totalLeaveDaysUsed: json['leaveUse']?.toString() ?? '0',
        totalMedicalFeesUsed: json['medFeeUse']?.toString() ?? '0',
        totalLeaveDaysRemaining: json['leaveRemain']?.toString() ?? '0',
        totalMedicalFeesRemaining: json['medFeeRemain']?.toString() ?? '0',
        endContract: json['endContract'],
        profile: '📄 View',
        actions: '✏️ Edit');
  }

  OverviewDatagridRow.mockUp()
      : empId = 'Test',
        empCode = "Test",
        fullName = "Test",
        nickName = "Test",
        leaveDayEntitlement = "0",
        medicalFeesEntitlement = "0",
        totalLeaveDaysUsed = "0",
        totalMedicalFeesUsed = "0",
        totalLeaveDaysRemaining = "0",
        totalMedicalFeesRemaining = "0",
        endContract = "22-01-22",
        profile = "a",
        actions = "edit";

  PlutoRow get plutoRow {
    return PlutoRow(cells: {
      'empId': PlutoCell(value: empId),
      'empCode': PlutoCell(value: empCode),
      'fullName': PlutoCell(value: fullName),
      'nickName': PlutoCell(value: nickName),
      'leaveDayEntitlement': PlutoCell(value: leaveDayEntitlement),
      'medicalFeesEntitlement': PlutoCell(value: medicalFeesEntitlement),
      'totalLeaveDaysUsed': PlutoCell(value: totalLeaveDaysUsed),
      'totalMedicalFeesUsed': PlutoCell(value: totalMedicalFeesUsed),
      'totalLeaveDaysRemaining': PlutoCell(value: totalLeaveDaysRemaining),
      'totalMedicalFeesRemaining': PlutoCell(value: totalMedicalFeesRemaining),
      'endContract': PlutoCell(value: endContract),
      'profile': PlutoCell(value: profile),
      'actions': PlutoCell(value: actions)
    });
  }
}
