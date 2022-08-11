import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:timesheet/components/data_grid/pluto_utils.dart';
import 'package:timesheet/components/diaglogs/layout/primary_dialog.dart';
import 'package:timesheet/domains/datagrid/overview_datagrid_row.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../constants.dart';
import '../../domains/employee.dart';
import '../../router/route_utils.dart';
import '../../services/employees_data_controller.dart';
import '../forms/update_employee_form_card.dart';

class OverviewDataGrid extends StatefulWidget {
  const OverviewDataGrid({
    Key? key,
    required this.rows,
    required this.columns,
    this.onDialogClosed,
    this.year,
    this.month,
  }) : super(key: key);
  final int? year;
  final Function()? onDialogClosed;
  final int? month;
  final List<PlutoRow> rows;
  final List<PlutoColumn> columns;

  @override
  State<OverviewDataGrid> createState() => _OverviewDataGridState();
}

class _OverviewDataGridState extends State<OverviewDataGrid> {
  late final PlutoGridStateManager stateManager;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: k50Height(context),
        child: PlutoGrid(
            columnGroups: OverviewDatagridInfo.plutoColumnGroups,
            columns: OverviewDatagridInfo.plutoColumns,
            rows: widget.rows,
            onLoaded: (PlutoGridOnLoadedEvent event) {
              stateManager = event.stateManager;
              // event.stateManager.setShowColumnFilter(true);
            },
            onSelected: (PlutoGridOnSelectedEvent event) async {
              if (event.row != null) {
                if (event.cell!.value.toString() == '✏️ Edit') {
                  var empId = event.row!.cells['empId']!.value;
                  Employee employee =
                      await getUserProfile(empId, context: context);
                  await showPrimaryDialog(context, children: [
                    UpdateEmployeeFormCard(employee: employee, empId: empId)
                  ]);

                  widget.onDialogClosed?.call();
                } else if (event.cell!.value.toString() == '📄 View') {
                  var empId = event.row!.cells['empId']!.value;
                  if (widget.year != null && widget.month != null) {
                    String month = widget.month! < 10
                        ? '0${widget.month}'
                        : widget.month.toString();
                    context.go(AppPage.userProfile.toRouteName +
                        '/empId/${empId}/at/${widget.year}${month}');
                  } else {
                    context.go(
                        AppPage.userProfile.toRouteName + '/empId/${empId}');
                  }
                }
              }
            },
            mode: PlutoGridMode.select,
            onChanged: (PlutoGridOnChangedEvent event) {
              print(event);
            },
            configuration: kGirdConfig));
  }
}
