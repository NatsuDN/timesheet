// By Admin vs By User

import 'package:pluto_grid/pluto_grid.dart';

import '../../components/data_grid/pluto_utils.dart';
import '../../utils.dart';

class CurrentUserMedicalRequestDatagridInfo {
  final List<CurrentUserMedicalRequestDatagridRow> rows;

  static final List<PlutoColumn> plutoColumns = <PlutoColumn>[
    //     'empCode': PlutoCell(value: empCode),
    // 'nickName': PlutoCell(value: nickName),
    // 'date': PlutoCell(value: date),
    // 'amount': PlutoCell(value: amount),
    // 'details': PlutoCell(value: details),
    // 'status': PlutoCell(value: status),
    // 'actions': PlutoCell(value: actions),
    textColummFixed('MedId', 'medId', hide: true),
    textColummFixed('EmpId', 'empId', hide: true),
    textColummFixed('Emp Code', 'empCode', width: 120),
    textColummFixed('Nickname', 'nickName', width: 80),
    textColummFixed('Date', 'date', width: 120),
    textColummFixed('Amount', 'amount', width: 120),
    textColummFixed('Note', 'note',
        width: 200, textAlign: PlutoColumnTextAlign.start),
    textColummFixed(
      'Status',
      'status',
    ),
    textColummFixed('Actions', 'actions'),
  ];

  CurrentUserMedicalRequestDatagridInfo({required this.rows});
  List<PlutoRow> get plutoRows {
    return rows
        .map((CurrentUserMedicalRequestDatagridRow row) => row.plutoRow)
        .toList();
  }
}

class CurrentUserMedicalRequestDatagridRow {
  final String medId,
      empCode,
      empId,
      nickName,
      date,
      amount,
      note,
      status,
      actions;
  CurrentUserMedicalRequestDatagridRow(
      {required this.medId,
      required this.empId,
      required this.empCode,
      required this.nickName,
      required this.date,
      required this.amount,
      required this.note,
      required this.status,
      required this.actions});

  factory CurrentUserMedicalRequestDatagridRow.fromJsonBy(
      Map<String, dynamic> json,
      {required String empId}) {
    return CurrentUserMedicalRequestDatagridRow(
      empId: empId,
      empCode: json['empCode'] ?? 'error',
      medId: json['medID'],
      nickName: json['nickName'],
      date: json['date'],
      note: json['note'],
      amount: json['amount'].toString(),
      status: getCapitalized(json['medStatus']),
      actions: '📄 View',
    );
  }

  CurrentUserMedicalRequestDatagridRow.mockUp()
      : empCode = 'empCode',
        empId = 'empId',
        nickName = 'nickName',
        medId = 'medId',
        date = 'date',
        amount = 'amount',
        note = 'note',
        status = 'status',
        actions = 'action';

  PlutoRow get plutoRow {
    return PlutoRow(cells: {
      'medId': PlutoCell(value: medId),
      'empId': PlutoCell(value: empId),
      'empCode': PlutoCell(value: empCode),
      'nickName': PlutoCell(value: nickName),
      'date': PlutoCell(value: date),
      'amount': PlutoCell(value: amount),
      'note': PlutoCell(value: note),
      'status': PlutoCell(value: status),
      'actions': PlutoCell(value: actions),
    });
  }
}
