// By Admin vs By User

import 'package:timesheet/utils.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../components/data_grid/pluto_utils.dart';

class MedicalRequestDatagridInfo {
  final List<MedicalRequestDatagridRow> rows;

  static final List<PlutoColumn> plutoColumns = <PlutoColumn>[
    // empCode = "empCode",
    // nickName = "Nickname",
    // date = "Date",
    // requestMedicalFees = "Request Medical Fees",
    // avaliableMedicalFees = "Avaliable Medical Fees",
    // details = "Details",
    // status = "Status",
    // actions = "Actions";
    textColummFixed('MedId', 'medId', hide: true),

    textColummFixed('Emp Code', 'empCode', width: 100),
    textColummFixed('Nickname', 'nickName', width: 100),
    textColummFixed('Date', 'date'),
    textColummFixed('Request Medical Fees', 'requestMedicalFees', width: 150),
    textColummFixed('Avaliable Medical Fees', 'avaliableMedicalFees',
        width: 150),
    textColummFixed('Details', 'details'),
    textColummFixed('Status', 'status'),
    textColummFixed('Actions', 'actions'),
  ];

  MedicalRequestDatagridInfo({required this.rows});
  List<PlutoRow> get plutoRows {
    return rows.map((MedicalRequestDatagridRow row) => row.plutoRow).toList();
  }
}

class MedicalRequestDatagridRow {
  final String empCode,
      medId,
      nickName,
      date,
      requestMedicalFees,
      avaliableMedicalFees,
      details,
      status,
      actions;
  MedicalRequestDatagridRow(
      {required this.medId,
      required this.empCode,
      required this.nickName,
      required this.date,
      required this.requestMedicalFees,
      required this.avaliableMedicalFees,
      required this.details,
      required this.status,
      required this.actions});

  factory MedicalRequestDatagridRow.fromJsonByMedId(Map<String, dynamic> json,
      {required medId}) {
    return MedicalRequestDatagridRow(
        medId: medId,
        empCode: json['empCode'] ?? 'error',
        nickName: json['nickName'],
        date: json['date'],
        requestMedicalFees: json['requestMedicalFee'].toString(),
        avaliableMedicalFees: json['currentMedicalFee'].toString(),
        details: '📄 View',
        status: getCapitalized(json['medStatus']),
        actions: json['medStatus'] == 'INPROCESS' ? '🖋️ Review' : '-');
  }

  MedicalRequestDatagridRow.mockUp()
      : medId = 'MedId',
        empCode = "Test",
        nickName = "Test",
        date = "2022-01-22",
        requestMedicalFees = "0",
        avaliableMedicalFees = "0",
        details = "a",
        status = "a",
        actions = "a";

  PlutoRow get plutoRow {
    return PlutoRow(cells: {
      'medId': PlutoCell(value: medId),
      'empCode': PlutoCell(value: empCode),
      'nickName': PlutoCell(value: nickName),
      'date': PlutoCell(value: date),
      'requestMedicalFees': PlutoCell(value: requestMedicalFees),
      'avaliableMedicalFees': PlutoCell(value: avaliableMedicalFees),
      'details': PlutoCell(value: details),
      'status': PlutoCell(value: status),
      'actions': PlutoCell(value: actions),
    });
  }
}
