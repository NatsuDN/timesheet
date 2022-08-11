import 'package:timesheet/domains/company.dart';
import 'package:timesheet/domains/employee.dart';

class User {
  final String userName;
  final String id;

  final Employee employee;
  final Company company;

  const User({
    required this.id,
    required this.userName,
    required this.employee,
    required this.company,
  });

  factory User.fromJsonWithOutUsername(
      Map<String, dynamic> json, String userName) {
    return User(
      id: json['empID'] ?? 'error',
      userName: userName,
      employee: Employee(
          empCode: json['empCode'],
          userName: userName,
          firstName: json['firstName'],
          lastName: json['lastName'],
          nickName: json['nickName'],
          role: json['empRole'],
          holidayType: json['holidayID'],
          leaveDaysEntitlement: json['leaveLimit'],
          medicalFeesEntitlement: json['medFeeLimit'],
          leaveDaysUsed: json['leaveUse'],
          medicalFeesUsed: json['medFeeUse']),
      company: Company(name: json['orgNameEng'], id: json['orgID']),
    );
  }
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        userName: json['employee']['username'] ?? 'erorr',
        id: json['empID'] ?? 'error',
        employee: Employee.fromJson(json['employee']),
        company: Company.fromJson(json['company']));
  }

  Map<String, dynamic> toJson() {
    return {
      'empID': id,
      'username': userName,
      'employee': employee.toJson(),
      'company': company.toJson(),
    };
  }

  User.mockUp()
      : userName = "test",
        id = "QHyXNIIBa0CUUmxeEQAE",
        employee = Employee.mockUp(),
        company = Company.mockUp();
}
