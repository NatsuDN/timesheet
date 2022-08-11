// Admin and User Viewimport 'package:flutter/material.dart';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:timesheet/components/data_grid/pluto_utils.dart';
import 'package:timesheet/components/diaglogs/layout/primary_dialog.dart';
import 'package:timesheet/components/forms/manage_medical_request_form_card.dart';
import 'package:timesheet/constants.dart';
import 'package:timesheet/domains/medical_request.dart';
import 'package:timesheet/services/employees_data_controller.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../domains/employee.dart';
import '../forms/manage_employee_form_card.dart';

class CurrentUserMedicalRequestsDataGrid extends StatefulWidget {
  const CurrentUserMedicalRequestsDataGrid({
    Key? key,
    required this.rows,
    required this.columns,
  }) : super(key: key);
  final List<PlutoRow> rows;
  final List<PlutoColumn> columns;

  @override
  State<CurrentUserMedicalRequestsDataGrid> createState() =>
      _CurrentUserMedicalRequestsDataGridState();
}

class _CurrentUserMedicalRequestsDataGridState
    extends State<CurrentUserMedicalRequestsDataGrid> {
  late final PlutoGridStateManager stateManager;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: k30Height(context),
      child: PlutoGrid(
        columns: widget.columns,
        rows: widget.rows,
        onLoaded: (PlutoGridOnLoadedEvent event) {
          stateManager = event.stateManager;
        },
        onChanged: (PlutoGridOnChangedEvent event) {
          print(event);
        },
        configuration: kGirdConfig,
        rowColorCallback: (rowColorContext) {
          // [ APPROVE, NOTAPPROVE, INPROCESS ]
          var rowValue =
              rowColorContext.row.cells.entries.elementAt(7).value.value;
          log(rowValue);
          if (rowValue == 'Inprocess') {
            return kOrange.withOpacity(0.25);
          } else if (rowValue == 'Approve') {
            return kGreen.withOpacity(0.25);
          } else if (rowValue == 'Notapprove') {
            return kRed.withOpacity(0.25);
          }

          return kThemeSecondaryBackgroundColor;
        },
        onSelected: (PlutoGridOnSelectedEvent event) async {
          if (event.row != null) {
            if (event.cell!.value.toString() == '📄 View') {
              var medId = widget.rows[event.rowIdx!].cells['medId']!.value;

              MedicalRequest medicalRequest =
                  await getMedicalRequestDetails(medId, context: context);

              Employee? employee =
                  await getUserProfile(medicalRequest.empId, context: context);

              await showPrimaryDialog(context, children: [
                MedicalRequestFormCard(
                    dialogType: MedicalRequestDialogType.view,
                    medicalRequest: medicalRequest,
                    employee: employee!),
              ]);
            }
          }
        },
        mode: PlutoGridMode.select,
      ),
    );
  }
}
