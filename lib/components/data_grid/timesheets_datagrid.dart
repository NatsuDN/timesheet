import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:timesheet/components/data_grid/pluto_utils.dart';
import 'package:timesheet/components/diaglogs/layout/primary_dialog.dart';
import 'package:timesheet/router/route_utils.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../constants.dart';
import '../../domains/employee.dart';
import '../forms/manage_employee_form_card.dart';

class TimesheetsDataGrid extends StatefulWidget {
  const TimesheetsDataGrid({
    Key? key,
    required this.rows,
    required this.columns,
    this.year,
    this.month,
  }) : super(key: key);
  final List<PlutoRow> rows;
  final List<PlutoColumn> columns;
  final int? year;
  final int? month;

  @override
  State<TimesheetsDataGrid> createState() => _TimesheetsDataGridState();
}

class _TimesheetsDataGridState extends State<TimesheetsDataGrid> {
  late final PlutoGridStateManager stateManager;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: k50Height(context),
      child: PlutoGrid(
        columns: widget.columns,
        rows: widget.rows,
        rowColorCallback: (rowColorContext) {
          var rowValue =
              rowColorContext.row.cells.entries.elementAt(4).value.value;
          print(rowValue);
          if (rowValue == 'Completed') {
            return kGreen.withOpacity(0.25);
          } else if (rowValue == 'Incompleted') {
            return kOrange.withOpacity(0.25);
          }

          return kThemeSecondaryBackgroundColor;
        },
        onLoaded: (PlutoGridOnLoadedEvent event) {
          stateManager = event.stateManager;
        },
        onChanged: (PlutoGridOnChangedEvent event) {
          print(event);
        },
        configuration: kGirdConfig,
        onRowDoubleTap: (PlutoGridOnRowDoubleTapEvent event) async {
          if (event.row != null && event.cell!.value.toString() == '📄 View') {
            var empId = event.row!.cells['empId']!.value;
            if (widget.year != null && widget.month != null) {
              String month = widget.month! < 10
                  ? '0${widget.month}'
                  : widget.month.toString();
              context.go(AppPage.userProfile.toRouteName +
                  '/empId/${empId}/at/${widget.year}${month}');
            } else {
              context.go(AppPage.userProfile.toRouteName + '/empId/${empId}');
            }
          }
        },
        mode: PlutoGridMode.select,
      ),
    );
  }
}
