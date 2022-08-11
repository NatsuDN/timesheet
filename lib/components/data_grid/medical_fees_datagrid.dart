// Admin and User Viewimport 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:timesheet/components/data_grid/pluto_utils.dart';
import 'package:timesheet/components/diaglogs/layout/primary_dialog.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../constants.dart';
import '../../domains/employee.dart';
import '../forms/manage_employee_form_card.dart';

class MedicalFeesDataGrid extends StatefulWidget {
  const MedicalFeesDataGrid({
    Key? key,
    required this.rows,
    required this.columns,
  }) : super(key: key);
  final List<PlutoRow> rows;
  final List<PlutoColumn> columns;

  @override
  State<MedicalFeesDataGrid> createState() => _TimesheetDetailDataGridState();
}

class _TimesheetDetailDataGridState extends State<MedicalFeesDataGrid> {
  late final PlutoGridStateManager stateManager;

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
      ),
    );
  }
}
