import 'package:flutter/material.dart';
import 'package:timesheet/components/buttons/layout/primary_button.dart';
import 'package:timesheet/components/data_grid/pluto_utils.dart';
import 'package:timesheet/components/diaglogs/layout/primary_dialog.dart';
import 'package:timesheet/constants.dart';
import 'package:timesheet/domains/datagrid/timesheets_details_datagrid_row.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../domains/datagrid/timesheets_datagrid_row.dart';
import '../../domains/employee.dart';
import '../../services/employees_data_controller.dart';
import '../../utils.dart';
import '../forms/manage_employee_form_card.dart';

class TimesheetDetailsDataGrid extends StatefulWidget {
  const TimesheetDetailsDataGrid({
    Key? key,
    required this.timesheetsDetailsDatagirdInfo,
    this.onPressed,
    required this.empId,
  }) : super(key: key);
  final TimesheetsDetailsDatagirdInfo timesheetsDetailsDatagirdInfo;
  final Function()? onPressed;
  final String empId;
  @override
  State<TimesheetDetailsDataGrid> createState() =>
      _TimesheetDetailsDataGridState();
}

class _TimesheetDetailsDataGridState extends State<TimesheetDetailsDataGrid> {
  late final PlutoGridStateManager stateManager;

  late List<PlutoRow> pluToRows =
      widget.timesheetsDetailsDatagirdInfo.plutoRows;

  onPressed() async {
    var rows =
        TimesheetsDetailsDatagridRow.plutoRowsToTimesheetsDetailsDatagridRows(
      pluToRows,
    );

    TimesheetsDetailsDatagirdInfo newInfo =
        TimesheetsDetailsDatagirdInfo(rows: rows);

    await updateTimesheetsDetails(newInfo,
        empId: widget.empId, context: context);
    await widget.onPressed?.call();
  }

  @override
  void didUpdateWidget(covariant TimesheetDetailsDataGrid oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: 1480,
          child: PlutoGrid(
            columns: TimesheetsDetailsDatagirdInfo.plutoColumns,
            rows: pluToRows,
            rowColorCallback: (rowColorContext) {
              // [ LEAVE, HALFDAY, WORK, HOLIDAY, OT, RECORD, NORECORD ]
              var rowValue =
                  rowColorContext.row.cells.entries.elementAt(3).value.value;
              if (rowValue == 'Pending') {
                return kOrange.withOpacity(0.25);
              } else if (rowValue == 'Work') {
                return kGreen.withOpacity(0.25);
              } else if (rowValue == 'OT') {
                return kGreen.withOpacity(0.5);
              } else if (rowValue == 'Holiday') {
                return kHeaderFontColor.withOpacity(0.1);
              } else if (rowValue == 'Work(Updated)') {
                return kThemeColor.withOpacity(0.25);
              } else if (rowValue == 'Leave') {
                return kHeaderFontColor.withOpacity(0.20);
              } else if (rowValue == 'Halfday') {
                return kGreen.withOpacity(0.10);
              }

              return kThemeSecondaryBackgroundColor;
            },
            onLoaded: (PlutoGridOnLoadedEvent event) {
              stateManager = event.stateManager;
            },
            onChanged: (PlutoGridOnChangedEvent event) {
              bool isEditTime = [5, 6].contains(event.columnIdx);
              bool isLeaveDay =
                  pluToRows[event.rowIdx!].cells['status']!.value == 'Leave';
              bool isHoliday =
                  pluToRows[event.rowIdx!].cells['status']!.value ==
                          'Holiday' ||
                      event.oldValue == 'Holiday';

              if (isEditTime) {
                print('isEditTime');
                var columnName = event.columnIdx == 5 ? 'timeIn' : 'timeOut';
                var timeValue =
                    pluToRows[event.rowIdx!].cells[columnName]!.value;

                pluToRows[event.rowIdx!].cells[columnName]!.value =
                    isValidTimeText(timeValue) ? timeValue : "00:00";
              }
              if (isLeaveDay) {
              } else {
                print(pluToRows[event.rowIdx!].cells['status']);
                pluToRows[event.rowIdx!].cells['status']!.value =
                    'Work(Updated)';
              }
            },
            configuration: kGirdConfig,
          ),
        ),
        Padding(
          padding: kTopSpaceMedium,
          child: Column(
            children: [
              buildSummaryRow('Total Work',
                  '${widget.timesheetsDetailsDatagirdInfo.sum?.totalWork}'),
              buildSummaryRow('Total OT',
                  '${widget.timesheetsDetailsDatagirdInfo.sum?.totalOT}'),
              buildSummaryRow('Total Leave',
                  '${widget.timesheetsDetailsDatagirdInfo.sum?.totalLeave}'),
            ],
          ),
        ),
        Center(
          child: Container(
              width: 120,
              margin: kVerticalSpaceMedium,
              child: PrimaryButton(text: 'Update', onPressed: onPressed)),
        )
      ],
    );
  }

  Container buildSummaryRow(title, value) {
    return Container(
      width: 120,
      margin: kBottomSpaceSmall,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: kBody2TextStyle.copyWith(color: kPrimaryFontColor),
          ),
          Text(
            value ?? '0',
            style: kBody2TextStyle.copyWith(color: kPrimaryFontColor),
          )
        ],
      ),
    );
  }
}
