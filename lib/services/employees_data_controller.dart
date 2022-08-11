import 'dart:convert';
import 'dart:developer';

// import 'package:http/http.dart' as http;

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:timesheet/domains/datagrid/employee_benefits_yearly_summary/leave_days_datagrid_row.dart';
import 'package:timesheet/domains/datagrid/employee_benefits_yearly_summary/medical_fees_datagrid_row.dart';
import 'package:timesheet/domains/datagrid/medical_requests_datagrid_row.dart';
import 'package:timesheet/domains/datagrid/timesheets_datagrid_row.dart';
import 'package:timesheet/domains/datagrid/timesheets_details_datagrid_row.dart';
import 'package:timesheet/domains/employee.dart';
import 'package:timesheet/domains/holiday_type.dart';
import 'package:timesheet/domains/timesheet_detail_sum.dart';

import '../domains/datagrid/current_user_medical_requests_datagrid_row.dart';
import '../domains/datagrid/overview_datagrid_row.dart';
import '../domains/medical_request.dart';
import '../utils.dart';
import 'base_controller.dart';

const String kUserControllerUrl = "$kBaseUrl/api/v1/user";

/*
1. Post Method Example
 By Body
 final response = await http.post(
      Uri.parse(
        '$kBaseURL/registerUser',
      ),
      headers: {"Content-Type": "application/json"},
      body: json.encode(user.toJson()));
By Param      
final response = await http.post(
    Uri.parse(
      '$kBTSControllerUrl/shareTicket?customerUser=$userName&ticketNumber=$ticketNumber',
    ),
  );


2. Get Method Example
  final response = await http.get(Uri.parse(
    '$kBaseURL/getUser?userName=$userName&password=$password',
  ));
   List Example
      List<Ticket> tickets =
        parsedJson.map<Ticket>((json) => Ticket.fromJson(json)).toList();


*/

/* Respone Hanlding Example
  if (response.statusCode == 200) {
    return await loginUser(user.userName, user.password, context: context);
  } else {
    var body = json.decode(response.body);
    await showErrorDialog(context, body, isPop: false);
    return null;
  }
*/

/* MockUp Hanlding Example
   if (kIsMockup) {
    return await loginUser(user.userName, user.password, context: context);
    reutrn await jsonFromMockUpApi(context: context, "get_user.json");
  }
*/

Future<OverviewDatagridInfo> getOverview(orgId,
    {required year, required BuildContext context}) async {
  if (kIsMockup) {
    var parsedJson = await jsonFromMockUpApi(
        context: context,
        "employees_data/get_overview.json") as Map<String, dynamic>;
    log('parsedJson: $parsedJson');
    // Iterate over the map  and create a list of OverviewDatagridRow objects.
    List<OverviewDatagridRow> overviewDatagridRows =
        parsedJson.entries.map((entry) {
      // log(entry.value);
      return OverviewDatagridRow.fromJsonByEmpId(entry.value, empId: entry.key);
    }).toList();

    log('parsedJson: $overviewDatagridRows');
    return OverviewDatagridInfo(
      rows: overviewDatagridRows,
    );
  }
  try {
    final response = await kDioAdmin
        .post('/getOverView', data: {"orgID": orgId, "year": year});
    var body = response.data;
    log('body: $body');
    List<OverviewDatagridRow> overviewDatagridRows =
        body.entries.map<OverviewDatagridRow>((entry) {
      return OverviewDatagridRow.fromJsonByEmpId(entry.value, empId: entry.key);
    }).toList();
    overviewDatagridRows.sort((a, b) => a.empCode.compareTo(b.empCode));
    return OverviewDatagridInfo(rows: overviewDatagridRows);
  } on DioError catch (e) {
    await showErrorDialog(context, e.message);

    return OverviewDatagridInfo(rows: []);
  }
}

// ---
Future<TimesheetsDatagridInfo> getTimesheets(orgId,
    {required month, required year, required BuildContext context}) async {
  if (kIsMockup) {
    var parsedJson = await jsonFromMockUpApi(
        context: context,
        "employees_data/get_timesheets.json") as Map<String, dynamic>;
    List<TimeSheetsDatagridRow> timeSheetsDatagridRows =
        parsedJson.entries.map((entry) {
      return TimeSheetsDatagridRow.fromJsonByEmpId(entry.value,
          empId: entry.key);
    }).toList();

    return TimesheetsDatagridInfo(
      rows: timeSheetsDatagridRows,
    );
  }
  try {
    final response = await kDioAdmin.post('/getEveryOneTimesheetsSummary',
        data: {"orgID": orgId, "month": month, "year": year});
    var body = response.data;
    log('body: $body');
    List<TimeSheetsDatagridRow> timeSheetsDatagridRows =
        body.entries.map<TimeSheetsDatagridRow>((entry) {
      return TimeSheetsDatagridRow.fromJsonByEmpId(entry.value,
          empId: entry.key);
    }).toList();
    log('hi: $timeSheetsDatagridRows');
    timeSheetsDatagridRows.sort((a, b) => a.empCode.compareTo(b.empCode));
    return TimesheetsDatagridInfo(rows: timeSheetsDatagridRows);
  } on DioError catch (e) {
    await showErrorDialog(context, e.message);

    return TimesheetsDatagridInfo(rows: []);
  }
}

Future<LeaveDaysDatagridInfo> getLeaveDays(orgId,
    {required year, required BuildContext context}) async {
  if (kIsMockup) {
    var parsedJson = await jsonFromMockUpApi(
        context: context,
        "employees_data/get_leave_days.json") as Map<String, dynamic>;
    List<LeaveDaysDatagridRow> leaveDaysDatagridRows =
        parsedJson.entries.map((entry) {
      return LeaveDaysDatagridRow.fromJsonByEmpId(entry.value,
          empId: entry.key);
    }).toList();
    return LeaveDaysDatagridInfo(
      rows: leaveDaysDatagridRows,
    );
  }
  try {
    final response = await kDioAdmin
        .post('/getEveryOneLeaveDay', data: {"orgID": orgId, "year": year});
    var body = response.data;
    List<LeaveDaysDatagridRow> leaveDayRows =
        body.entries.map<LeaveDaysDatagridRow>((entry) {
      return LeaveDaysDatagridRow.fromJsonByEmpId(entry.value,
          empId: entry.key);
    }).toList();
    leaveDayRows.sort((a, b) => a.empCode.compareTo(b.empCode));
    return LeaveDaysDatagridInfo(rows: leaveDayRows);
  } on DioError catch (e) {
    await showErrorDialog(context, e.message);

    return LeaveDaysDatagridInfo(rows: []);
  }
}

Future<MedicalFeesDatagridInfo> getMedicalFees(orgId,
    {required year, required BuildContext context}) async {
  if (kIsMockup) {
    var parsedJson = await jsonFromMockUpApi(
        context: context,
        "employees_data/get_medical_fees.json") as Map<String, dynamic>;

    List<MedicalFeesDatagridRow> medicalFeesDatagridRows =
        parsedJson.entries.map((entry) {
      return MedicalFeesDatagridRow.fromJsonByEmpId(entry.value,
          empId: entry.key);
    }).toList();

    return MedicalFeesDatagridInfo(
      rows: medicalFeesDatagridRows,
    );
  }
  try {
    final response = await kDioAdmin
        .post('/getEveryOneMedicalFees', data: {"orgID": orgId, "year": year});
    var body = response.data;
    List<MedicalFeesDatagridRow> medFeesRow =
        body.entries.map<MedicalFeesDatagridRow>((entry) {
      return MedicalFeesDatagridRow.fromJsonByEmpId(entry.value,
          empId: entry.key);
    }).toList();
    medFeesRow.sort((a, b) => a.empCode.compareTo(b.empCode));
    return MedicalFeesDatagridInfo(rows: medFeesRow);
  } on DioError catch (e) {
    await showErrorDialog(context, e.message);

    return MedicalFeesDatagridInfo(rows: []);
  }
}

// ---
Future<MedicalRequestDatagridInfo> getMedicalRequests(orgId,
    {required year, required BuildContext context}) async {
  if (kIsMockup) {
    var parsedJson = await jsonFromMockUpApi(
            context: context, "employees_data/get_medical_fees_requests.json")
        as Map<String, dynamic>;
    List<MedicalRequestDatagridRow> medicalRequestDatagridRows =
        parsedJson.entries.map((entry) {
      return MedicalRequestDatagridRow.fromJsonByMedId(entry.value,
          medId: entry.key);
    }).toList();
    return MedicalRequestDatagridInfo(
      rows: medicalRequestDatagridRows,
    );
  }
  try {
    final response = await kDioAdmin.post('/getEveryOneMedicalFeesRequests',
        data: {"orgID": orgId, "year": year});
    var body = response.data;

    List<MedicalRequestDatagridRow> medRequestRows =
        body.entries.map<MedicalRequestDatagridRow>((entry) {
      return MedicalRequestDatagridRow.fromJsonByMedId(entry.value,
          medId: entry.key);
    }).toList();
    medRequestRows.sort((a, b) => a.empCode.compareTo(b.empCode));
    return MedicalRequestDatagridInfo(rows: medRequestRows);
  } on DioError catch (e) {
    await showErrorDialog(context, e.message);

    return MedicalRequestDatagridInfo(rows: []);
  }
}

Future<CurrentUserMedicalRequestDatagridInfo> getCurrentUserMedicalRequests(
    empId,
    {required BuildContext context}) async {
  if (kIsMockup) {
    var parsedJson = await jsonFromMockUpApi(
            context: context, "employees_data/get_medical_fees_requests.json")
        as Map<String, dynamic>;
    List<CurrentUserMedicalRequestDatagridRow> currentMedRows =
        parsedJson.entries.map((entry) {
      return CurrentUserMedicalRequestDatagridRow.fromJsonBy(
        entry.value,
        empId: empId,
      );
    }).toList();
    return CurrentUserMedicalRequestDatagridInfo(
      rows: currentMedRows,
    );
  }
  try {
    final response = await kDioEmployee.post('/geMyMedRequests', data: {
      "empID": empId,
    });
    var body = response.data;

    List<CurrentUserMedicalRequestDatagridRow> currentMedRows =
        body.entries.map<CurrentUserMedicalRequestDatagridRow>((entry) {
      return CurrentUserMedicalRequestDatagridRow.fromJsonBy(
        entry.value,
        empId: empId,
      );
    }).toList();
    currentMedRows.sort((a, b) => a.empCode.compareTo(b.empCode));
    return CurrentUserMedicalRequestDatagridInfo(rows: currentMedRows);
  } on DioError catch (e) {
    await showErrorDialog(context, e.message);

    return CurrentUserMedicalRequestDatagridInfo(rows: []);
  }
}

Future<List<HolidayType>> getHolidayTypes(orgId,
    {required BuildContext context}) async {
  if (kIsMockup) {
    var parsedJson = await jsonFromMockUpApi(
        context: context,
        "employees_data/get_holiday_type.json") as Map<String, dynamic>;
    // parsedJson = parsedJson;

    List<HolidayType> holidayTypes = parsedJson.entries.map((entry) {
      return HolidayType.fromJsonId(entry.value, id: entry.key);
    }).toList();
    return holidayTypes;
  }
  try {
    final response =
        await kDioAdmin.post('/getAllHoliday', data: {"orgID": orgId});
    var body = response.data;

    List<HolidayType> holidayTypes = body.entries.map<HolidayType>((entry) {
      return HolidayType.fromJsonId(entry.value, id: entry.key);
    }).toList();
    return holidayTypes;
  } on DioError catch (e) {
    await showErrorDialog(context, e.message);

    return [];
  }
}

updateHolidayType(id, datelist, {required BuildContext context}) async {
  if (kIsMockup) {
    return true;
  }
  try {
    print('UPDATE HOLIDAY');
    await kDioAdmin.post('/updateHolidayType',
        data: json.encode({
          'holidayID': id,
          'holidayList': datelist.map((date) => getFormatDate(date)).toList(),
        }));
    return true;
  } on DioError catch (e) {
    await showErrorDialog(context, e.message);
    if (e.response != null) {
      print(e.response!.data);
      print(e.response!.headers);
      print(e.response!.requestOptions.data);
    } else {
      // Something happened in setting up or sending the request that triggered an Error
      print(e.requestOptions);
      print(e.message);
    }
  }
}

createHolidayType(orgId, name, dateList,
    {required BuildContext context}) async {
  if (kIsMockup) {
    return true;
  }
  try {
    await kDioAdmin.post('/createHolidayType',
        data: json.encode({
          'orgID': orgId,
          'holidayName': name,
          'holidayList': dateList.map((date) => getFormatDate(date)).toList()
        }));
    return true;
  } on DioError catch (e) {
    await showErrorDialog(context, e.message);
    if (e.response != null) {
      print(e.response!.data);
      print(e.response!.headers);
      print(e.response!.requestOptions.data);
    } else {
      // Something happened in setting up or sending the request that triggered an Error
      print(e.requestOptions);
      print(e.message);
    }
  }
}

Future<TimesheetsDetailsDatagirdInfo> getTimesheetsDetails(
  empId, {
  required BuildContext context,
  required month,
  required year,
}) async {
  if (kIsMockup) {
    var parsedJson = await jsonFromMockUpApi(
        context: context,
        "user_profile/get_timesheets_details.json") as Map<String, dynamic>;
    parsedJson = parsedJson;

    List<TimesheetsDetailsDatagridRow> timeSheetsDetailsDatagridRows =
        parsedJson.entries.map<TimesheetsDetailsDatagridRow>((entry) {
      log(DateTime.parse(entry.key).toString());
      return TimesheetsDetailsDatagridRow.fromJsonByDateTime(entry.value,
          isoTime: entry.key);
    }).toList();
    return TimesheetsDetailsDatagirdInfo(
        rows: timeSheetsDetailsDatagridRows,
        sum: TimesheetsDetailsSum.mockUp());
  }
  try {
    final response = await kDioEmployee.post(
      '/getMyTimesheetMonth',
      data: {"empID": empId, "month": month, "year": year},
    );

    var body = response.data;
    //create a list of TimesheetsDetailsDatagridRow objects from start and end time of month;

    List<TimesheetsDetailsDatagridRow> unrecordedRows =
        TimesheetsDetailsDatagridRow.getMonthLists(year, month);
    List<TimesheetsDetailsDatagridRow> recordedRows =
        body.entries.map<TimesheetsDetailsDatagridRow>((entry) {
      return TimesheetsDetailsDatagridRow.fromJsonByDateTime(entry.value,
          isoTime: entry.key);
    }).toList();

    List<TimesheetsDetailsDatagridRow> finalRows =
        unrecordedRows.map<TimesheetsDetailsDatagridRow>((unrecordRow) {
      var row = recordedRows.firstWhere((recordRow) {
        // IF there is a record for this date, then return the record row. else keep it unrecord
        return recordRow.date == unrecordRow.date;
      }, orElse: () => unrecordRow);
      return row;
    }).toList();

    // {...unrecordedRows, ...recordedRow}.toList();
    TimesheetsDetailsSum sum = await getTimesheetDetailsSum(empId,
        month: month, year: year, context: context);
    return TimesheetsDetailsDatagirdInfo(rows: finalRows, sum: sum);
  } on DioError catch (e) {
    await showErrorDialog(context, e.message);

    return TimesheetsDetailsDatagirdInfo(
        rows: [], sum: TimesheetsDetailsSum.empty());
  }
}

Future<TimesheetsDetailsSum> getTimesheetDetailsSum(
  empId, {
  required BuildContext context,
  required month,
  required year,
}) async {
  if (kIsMockup) {
    // var parsedJson = await jsonFromMockUpApi(
    //     context: context,
    //     "user_profile/get_timesheets_details.json") as Map<String, dynamic>;
    // parsedJson = parsedJson;
    // //TODO
    return TimesheetsDetailsSum.mockUp();
  }

  try {
    final response = await kDioEmployee.post(
      '/getSumMyMonth',
      data: {"empID": empId, "month": month, "year": year},
    );
    var body = response.data;
    return TimesheetsDetailsSum.fromJson(body);
  } on DioError catch (e) {
    await showErrorDialog(context, e.message);
    return TimesheetsDetailsSum.empty();
  }
}

updateTimesheetsDetails(TimesheetsDetailsDatagirdInfo info,
    {required String empId, required BuildContext context}) async {
  if (kIsMockup) {
    return true;
  }
  try {
    await kDioEmployee.post('/updateMyTimesheets',
        data: json.encode(info.toJsonRecord(empId)));
    return true;
  } on DioError catch (e) {
    await showErrorDialog(context, e.message);
  }
}

// ---

getMedicalRequestsByEmployeeUsername({required BuildContext context}) {}

getMedicalRequestDetails(String medID, {required BuildContext context}) async {
  try {
    final response = await kDioAdmin
        .post('/getMedicalRequestsDetails', data: {'medID': medID});

    MedicalRequest medReq = MedicalRequest.fromJson(response.data);
    return medReq;
  } on DioError catch (e) {
    await showErrorDialog(context, e.message);
  }
}

updateMedicalRequestsStatus(String medID, String medStatus,
    {required BuildContext context}) async {
  try {
    await kDioAdmin.post('/updateMedicalRequestsStatus',
        data: {"medID": medID, "medStatus": medStatus});
    return true;
  } on DioError catch (e) {
    await showErrorDialog(context, e.message);
  }
}

createMedicalRequest(String empCode, double amount, String note, String imgUrl,
    {required BuildContext context}) async {
  try {
    await kDioEmployee.post('/addMedRequests', data: {
      "empCode": empCode,
      "amount": amount,
      "note": note,
      "slipPic": imgUrl
    });
    return true;
  } on DioError catch (e) {
    await showErrorDialog(context, e.message);
  }
}

createLeaveRequest(String empCode,String start, String end, String type, String note,
    {required BuildContext context}) async {
  try {
    await kDioEmployee.post('/addLeaveRequests', data: {
      "empCode": empCode,
      "dateStart": start,
      "dateEnd": end,
      "note": note,
      "leaveType": type,
    });
    return true;
  } on DioError catch (e) {
    await showErrorDialog(context, e.message);
  }
}

registerEmployee(
    String orgID,
    String password,
    String firstName,
    String lastName,
    String nickName,
    double leaveLimit,
    double medFeeLimit,
    String holidayID,
    String empRole,
    String username,
    startDate,
    {required BuildContext context}) async {
  try {
    await kDioAdmin.post('/registerEmployee', data: {
      "orgID": orgID,
      "password": password,
      "firstName": firstName,
      "lastName": lastName,
      "nickName": nickName,
      "leaveLimit": leaveLimit,
      "medFeeLimit": medFeeLimit,
      "holidayID": holidayID,
      "empRole": empRole,
      "username": username,
      "startDate": startDate
    });
    return true;
  } on DioError catch (e) {
    await showErrorDialog(context, e.message);
  }
}

Future getUserProfile(String empID, {required BuildContext context}) async {
  try {
    final response =
        await kDioEmployee.post('/getUserProfile', data: {"empID": empID});
    var body = response.data;
    print(body);
    Employee employee = Employee.fromJson(body);
    print(employee.toJson());
    return employee;
  } on DioError catch (e) {
    await showErrorDialog(context, e.message);
  }
}

updateUserProfile(
    String empID,
    String firstName,
    String lastName,
    String nickName,
    double leaveLimit,
    double medFeeLimit,
    String holidayID,
    String empRole,
    {required BuildContext context}) async {
  try {
    print(empID);
    await kDioAdmin.post('/updateUserProfile', data: {
      "empID": empID,
      "firstName": firstName,
      "lastName": lastName,
      "nickName": nickName,
      "leaveLimit": leaveLimit,
      "medFeeLimit": medFeeLimit,
      "holidayID": holidayID,
      "empRole": empRole
    });
    return true;
  } on DioError catch (e) {
    await showErrorDialog(context, e.message);
  }
}
