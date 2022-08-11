import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timesheet/components/buttons/employees_data_more_button.dart';
import 'package:timesheet/components/data_grid/timesheets_datagrid.dart';
import 'package:timesheet/components/forms/layout/primary_dropdown.dart';
import 'package:timesheet/components/page_wrapper/layout/primary_page_wrapper.dart';
import 'package:timesheet/components/primary_circular_progress_indicator.dart';
import 'package:timesheet/constants.dart';
import 'package:timesheet/domains/datagrid/employee_benefits_yearly_summary/leave_days_datagrid_row.dart';
import 'package:timesheet/domains/datagrid/employee_benefits_yearly_summary/medical_fees_datagrid_row.dart';
import 'package:timesheet/domains/datagrid/medical_requests_datagrid_row.dart';
import 'package:timesheet/domains/datagrid/overview_datagrid_row.dart';
import 'package:timesheet/domains/datagrid/timesheets_datagrid_row.dart';
import 'package:timesheet/providers/auth_provider.dart';
import 'package:timesheet/providers/holiday_type_provider.dart';
import 'package:timesheet/router/route_utils.dart';
import 'package:timesheet/services/employees_data_controller.dart';
import 'package:timesheet/utils.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../components/data_grid/leave_days_datagrid.dart';
import '../../components/data_grid/medical_fees_datagrid.dart';
import '../../components/data_grid/medical_requests_datagrid.dart';
import '../../components/data_grid/overview_datagrid.dart';
import '../../domains/datagrid/overview_datagrid_row.dart';
import 'employees_data_tab_bar.dart';

enum EmployeesDataGridPageTab {
  overview,
  timeSheets,
  leaveDays,
  medicalFees,
  medicalRequests
}

class EmployeesDataGridPage extends ConsumerStatefulWidget {
  const EmployeesDataGridPage({Key? key, required this.orgId})
      : super(key: key);
  final String orgId;
  @override
  EmployeesDataGridPageState createState() => EmployeesDataGridPageState();
}

class EmployeesDataGridPageState extends ConsumerState<EmployeesDataGridPage> {
  EmployeesDataGridPageTab _currentTab = EmployeesDataGridPageTab.overview;
  int year = DateTime.now().year;
  int month = DateTime.now().month;
  bool reload = false;
  late Future<OverviewDatagridInfo> _getOverviewDatagridInfo;
  late Future<TimesheetsDatagridInfo> _getTimesheetsDatagridInfo;
  late Future<LeaveDaysDatagridInfo> _getLeaveDaysDatagridInfo;
  late Future<MedicalFeesDatagridInfo> _getMedicalFeesDatagridInfo;
  late Future<MedicalRequestDatagridInfo> _getMedicalRequestsDatagridInfo;
  @override
  void initState() {
    _getOverviewDatagridInfo =
        getOverview(widget.orgId, year: year, context: context);
    // _getTimesheetsDatagridInfo = getTimesheets( ref.watch(authControllerProvider).user!.company.id , month: 7, year: 2022, context : context);
    _getTimesheetsDatagridInfo =
        getTimesheets(widget.orgId, month: month, year: year, context: context);
    _getLeaveDaysDatagridInfo =
        getLeaveDays(widget.orgId, year: year, context: context);
    _getMedicalFeesDatagridInfo =
        getMedicalFees(widget.orgId, year: year, context: context);
    _getMedicalRequestsDatagridInfo =
        getMedicalRequests(widget.orgId, year: year, context: context);
    ref.read(holidayTypeProvider);

    super.initState();
  }

  onTabChanged(EmployeesDataGridPageTab tab) {
    getTimesheets(widget.orgId, month: month, year: year, context: context);
    setState(() {
      _currentTab = tab;
    });
  }

  _buildDataGrid() {
    if (_currentTab == EmployeesDataGridPageTab.overview) {
      return FutureBuilder(
          future: _getOverviewDatagridInfo,
          builder: (context, AsyncSnapshot<OverviewDatagridInfo> snapshot) {
            if (snapshot.hasData) {
              var overviewDatagridInfo = snapshot.data;
              return OverviewDataGrid(
                onDialogClosed: onChange,
                rows: overviewDatagridInfo!.plutoRows,
                columns: OverviewDatagridInfo.plutoColumns,
                year: year,
                month: month,
              );
            } else {
              return const PrimaryCircularProgressIndicator();
            }
          });
    } else if (_currentTab == EmployeesDataGridPageTab.timeSheets) {
      return FutureBuilder(
          future: _getTimesheetsDatagridInfo,
          builder: (context, AsyncSnapshot<TimesheetsDatagridInfo> snapshot) {
            if (snapshot.hasData) {
              var timesheetsDatagridInfo = snapshot.data;
              return TimesheetsDataGrid(
                rows: timesheetsDatagridInfo!.plutoRows,
                columns: TimesheetsDatagridInfo.plutoColumns,
                year: year,
                month: month,
              );
            } else {
              return const PrimaryCircularProgressIndicator();
            }
          });
    } else if (_currentTab == EmployeesDataGridPageTab.leaveDays) {
      return FutureBuilder(
          future: _getLeaveDaysDatagridInfo,
          builder: (context, AsyncSnapshot<LeaveDaysDatagridInfo> snapshot) {
            if (snapshot.hasData) {
              var leaveDaysDatagridInfo = snapshot.data;
              return LeaveDaysDataGrid(
                rows: leaveDaysDatagridInfo!.plutoRows,
                columns: LeaveDaysDatagridInfo.plutoColumns,
              );
            } else {
              return const PrimaryCircularProgressIndicator();
            }
          });
    } else if (_currentTab == EmployeesDataGridPageTab.medicalFees) {
      return FutureBuilder(
          future: _getMedicalFeesDatagridInfo,
          builder: (context, AsyncSnapshot<MedicalFeesDatagridInfo> snapshot) {
            if (snapshot.hasData) {
              var medicalFeesDatagridInfo = snapshot.data;
              return MedicalFeesDataGrid(
                rows: medicalFeesDatagridInfo!.plutoRows,
                columns: MedicalFeesDatagridInfo.plutoColumns,
              );
            } else {
              return const PrimaryCircularProgressIndicator();
            }
          });
    } else if (_currentTab == EmployeesDataGridPageTab.medicalRequests) {
      return FutureBuilder(
          future: _getMedicalRequestsDatagridInfo,
          builder:
              (context, AsyncSnapshot<MedicalRequestDatagridInfo> snapshot) {
            if (snapshot.hasData) {
              var medicalRequestsDatagridInfo = snapshot.data;
              return MedicalRequestsDataGrid(
                onReviewDialogClosed: onChange,
                rows: medicalRequestsDatagridInfo!.plutoRows,
                columns: MedicalRequestDatagridInfo.plutoColumns,
              );
            } else {
              return const PrimaryCircularProgressIndicator();
            }
          });
    } else {
      return Container();
    }
  }

  onChange() {
    setState(() {
      reload = true;
      _getOverviewDatagridInfo = _getOverviewDatagridInfo =
          getOverview(widget.orgId, year: year, context: context);

      // _getTimesheetsDatagridInfo = getTimesheets( ref.watch(authControllerProvider).user!.company.id , month: 7, year: 2022, context : context);
      _getTimesheetsDatagridInfo = getTimesheets(widget.orgId,
          month: month, year: year, context: context);
      _getLeaveDaysDatagridInfo =
          getLeaveDays(widget.orgId, year: year, context: context);
      _getMedicalFeesDatagridInfo =
          getMedicalFees(widget.orgId, year: year, context: context);
      _getMedicalRequestsDatagridInfo =
          getMedicalRequests(widget.orgId, year: year, context: context);
    });
    Future.delayed(Duration(milliseconds: 100)).then((_) {
      setState(() {
        reload = false;
      });
    });
  }

  /// [PlutoGridStateManager] has many methods and properties to dynamically manipulate the grid.
  /// You can manipulate the grid dynamically at runtime by passing this through the [onLoaded] callback.

  @override
  Widget build(BuildContext context) {
    if (ref.watch(holidayTypeProvider).isEmpty) {
      ref.read(holidayTypeProvider.notifier).loadHolidayTypeLists(
          ref.watch(authControllerProvider).user!.company.id, context);
    }
    return PrimaryPageWrapper(
        title: 'Employees Data',
        tabBar: EmployeesDataTabBar(
          onTabChanged: onTabChanged,
        ),
        moreButton: EmployeesDataMoreButton(
          onDialogClosed: onChange,
        ),
        onExport: (){},
        routeLocation: AppPage.employeesData.toRouteName,
        body: reload
            ? const PrimaryCircularProgressIndicator()
            : Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: PrimaryDropDown(
                          title: 'Month',
                          items: getListofMonths(),
                          defaultValue:
                              month < 10 ? '0${month}' : month.toString(),
                          onChanged: (newMonth) {
                            month = int.parse(newMonth);

                            onChange();
                          },
                        ),
                      ),
                      Expanded(
                        child: PrimaryDropDown(
                          title: 'Year',
                          items: getListofYears(5),
                          defaultValue: year.toString(),
                          onChanged: (newYear) {
                            year = int.parse(newYear);
                            onChange();
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: kMedium),
                  _buildDataGrid()
                ],
              ));
  }
}
