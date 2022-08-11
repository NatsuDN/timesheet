import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:timesheet/components/bars/profile_bar.dart';
import 'package:timesheet/components/buttons/layout/primary_button.dart';
import 'package:timesheet/components/buttons/profile_more_button.dart';
import 'package:timesheet/components/data_grid/medical_requests_datagrid.dart';
import 'package:timesheet/components/data_grid/timesheets_details_datagrid.dart';
import 'package:timesheet/components/forms/layout/primary_dropdown.dart';

import 'package:timesheet/components/page_wrapper/layout/primary_page_wrapper.dart';
import 'package:timesheet/components/page_wrapper/layout/primary_scaffold.dart';
import 'package:timesheet/constants.dart';
import 'package:timesheet/domains/datagrid/current_user_medical_requests_datagrid_row.dart';
import 'package:timesheet/domains/datagrid/medical_requests_datagrid_row.dart';
import 'package:timesheet/domains/datagrid/timesheets_datagrid_row.dart';
import 'package:timesheet/router/route_utils.dart';
import 'package:timesheet/screens/user_profile_page/profile_tab_bar.dart';
import 'package:timesheet/services/employees_data_controller.dart';
import 'package:timesheet/utils.dart';

import '../../components/data_grid/current_user_medical_requests_datagrid.dart';
import '../../components/primary_circular_progress_indicator.dart';
import '../../domains/datagrid/timesheets_details_datagrid_row.dart';
import '../../domains/employee.dart';

enum UserProfileTab {
  timeSheetDetails,
  meicalRequests,
}

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({
    Key? key,
    required this.empId,
    this.year,
    this.month,
    this.fullName,
    this.isAdminView = false,
  }) : super(key: key);
  final int? year;
  final int? month;
  final String? fullName;
  final String empId;
  final bool isAdminView;
  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  UserProfileTab _currentTab = UserProfileTab.timeSheetDetails;
  late int year = widget.year ?? DateTime.now().year;
  late String fullName = widget.fullName ?? '';
  late int month = widget.month ?? DateTime.now().month;
  bool reload = false;
  late Future _getEmployeeProfile;
  late Future<TimesheetsDetailsDatagirdInfo> _getTimesheetsDetailsDatagridInfo;
  late Future<CurrentUserMedicalRequestDatagridInfo>
      _getCurrentUserMedicalRequests;

  @override
  void initState() {
    super.initState();
    _getTimesheetsDetailsDatagridInfo = getTimesheetsDetails(widget.empId,
        year: year, month: month, context: context);
    _getCurrentUserMedicalRequests =
        getCurrentUserMedicalRequests(widget.empId, context: context);
    _getEmployeeProfile = getUserProfile(widget.empId, context: context);
  }

  // final MedicalRequestDatagridInfo _medicalRequestDatagridInfo =
  //     MedicalRequestDatagridInfo(rows: [
  //   MedicalRequestDatagridRow.mockUp(),
  //   MedicalRequestDatagridRow.mockUp()
  // ]);

  onTabChanged(UserProfileTab tab) {
    getTimesheetsDetails(widget.empId,
        year: year, month: month, context: context);

    setState(() {
      _currentTab = tab;
    });
  }

  onChange() {
    setState(() {
      reload = true;
      _getTimesheetsDetailsDatagridInfo = getTimesheetsDetails(widget.empId,
          year: year, month: month, context: context);
      _getCurrentUserMedicalRequests =
          getCurrentUserMedicalRequests(widget.empId, context: context);
    });

    Future.delayed(Duration(milliseconds: 100)).then((_) {
      setState(() {
        reload = false;
      });
    });
  }

  _buildTab() {
    switch (_currentTab) {
      case UserProfileTab.timeSheetDetails:
        return FutureBuilder(
            future: _getTimesheetsDetailsDatagridInfo,
            builder: (context,
                AsyncSnapshot<TimesheetsDetailsDatagirdInfo> snapshot) {
              if (snapshot.hasData) {
                var timeSheetsDetailsDatagridInfo = snapshot.data;

                return TimesheetDetailsDataGrid(
                  timesheetsDetailsDatagirdInfo: timeSheetsDetailsDatagridInfo!,
                  onPressed: onChange,
                  empId: widget.empId,
                );
              } else {
                return const PrimaryCircularProgressIndicator();
              }
            });
      case UserProfileTab.meicalRequests:
        return FutureBuilder(
            future: _getCurrentUserMedicalRequests,
            builder: (context,
                AsyncSnapshot<CurrentUserMedicalRequestDatagridInfo> snapshot) {
              if (snapshot.hasData) {
                var currentUserMedicalRequestsDatagridInfo = snapshot.data;
                return CurrentUserMedicalRequestsDataGrid(
                  rows: currentUserMedicalRequestsDatagridInfo!.plutoRows,
                  columns: CurrentUserMedicalRequestDatagridInfo.plutoColumns,
                );
              } else {
                return const PrimaryCircularProgressIndicator();
              }
            });

      default:
        return Container();
    }
  }

  _buildProfileBar() {
    return FutureBuilder(
        future: _getEmployeeProfile,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var employee = snapshot.data as Employee;
            log('employee');

            return ProfileBar(
              employee: employee,
            );
          } else {
            return Container();
          }
        });
  }

  _buildUserProfilePage({String? fullName}) {
    var isAdminView = widget.isAdminView;
    log('isAdminView $isAdminView');
    return PrimaryPageWrapper(
        profileBar: isAdminView ? _buildProfileBar() : const ProfileBar(),
        title: !isAdminView ? 'My Profile' : 'User Profile',
        tabBar: ProfileTabBar(onTabChanged: onTabChanged),
        moreButton: ProfileMoreButton(
          onDialogClosed: onChange,
        ),
        routeLocation: AppPage.userProfile.toRouteName,
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
                  _buildTab()
                ],
              ));
  }

  @override
  Widget build(BuildContext context) {
    return _buildUserProfilePage();
  }
}
