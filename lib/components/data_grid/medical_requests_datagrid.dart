// Admin and User Viewimport 'package:flutter/material.dart';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:timesheet/components/data_grid/pluto_utils.dart';
import 'package:timesheet/components/diaglogs/layout/primary_dialog.dart';
import 'package:timesheet/components/forms/manage_medical_request_form_card.dart';
import 'package:timesheet/constants.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../domains/employee.dart';
import '../../domains/medical_request.dart';
import '../../services/employees_data_controller.dart';

class MedicalRequestsDataGrid extends StatefulWidget {
  const MedicalRequestsDataGrid({
    Key? key,
    required this.rows,
    required this.columns,
    this.onReviewDialogClosed,
  }) : super(key: key);
  final List<PlutoRow> rows;
  final List<PlutoColumn> columns;
  final Function()? onReviewDialogClosed;
  @override
  State<MedicalRequestsDataGrid> createState() =>
      _MedicalRequestsDataGridState();
}

class _MedicalRequestsDataGridState extends State<MedicalRequestsDataGrid> {
  late final PlutoGridStateManager stateManager;
  bool isOpenDialog = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: k50Height(context),
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
          if (event.row != null &&
              !isOpenDialog &&
              ['🖋️ Review', '📄 View']
                  .contains(event.cell!.value.toString())) {
            isOpenDialog = true;
            var medId = widget.rows[event.rowIdx!].cells['medId']!.value;

            MedicalRequest medicalRequest =
                await getMedicalRequestDetails(medId, context: context);

            Employee? employee =
                await getUserProfile(medicalRequest.empId, context: context);

            if (event.cell!.value.toString() == '🖋️ Review') {
              await showPrimaryDialog(context, children: [
                MedicalRequestFormCard(
                    dialogType: MedicalRequestDialogType.approve,
                    medicalRequest: medicalRequest,
                    employee: employee!),
              ]);
              widget.onReviewDialogClosed?.call();
            } else if (event.cell!.value.toString() == '📄 View') {
              await showPrimaryDialog(context, children: [
                MedicalRequestFormCard(
                    dialogType: MedicalRequestDialogType.view,
                    medicalRequest: medicalRequest,
                    employee: employee!),
              ]);
            }
            isOpenDialog = false;
          }
        },
        mode: PlutoGridMode.select,
      ),
    );
  }
}
