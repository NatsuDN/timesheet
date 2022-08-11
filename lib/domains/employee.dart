class Employee {
  final String empCode,
      userName,
      firstName,
      lastName,
      nickName,
      role,
      holidayType;
  final double leaveDaysEntitlement;
  final double medicalFeesEntitlement;
  final double leaveDaysUsed;
  final double medicalFeesUsed;

  Employee(
      {required this.empCode,
      required this.userName,
      required this.firstName,
      required this.lastName,
      required this.nickName,
      required this.role,
      required this.holidayType,
      required this.leaveDaysEntitlement,
      required this.medicalFeesEntitlement,
      required this.leaveDaysUsed,
      required this.medicalFeesUsed});

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      empCode: json['empCode'] ?? 'error',
      userName: json['username'] ?? 'error',
      firstName: json['firstName'] ?? 'error',
      lastName: json['lastName'] ?? 'error',
      nickName: json['nickName'] ?? 'error',
      role: json['empRole'] ?? 'error',
      holidayType: json['holidayID'] ?? 'error',
      leaveDaysEntitlement:
          double.tryParse(json['leaveLimit']?.toString() ?? '') ?? 0,
      medicalFeesEntitlement:
          double.tryParse(json['medFeeLimit']?.toString() ?? '') ?? 0,
      leaveDaysUsed: double.tryParse(json['leaveUse']?.toString() ?? '') ?? 0,
      medicalFeesUsed:
          double.tryParse(json['medFeeUse']?.toString() ?? '') ?? 0,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'empCode': empCode,
      'username': userName,
      'firstName': firstName,
      'lastName': lastName,
      'nickName': nickName,
      'empRole': role,
      'holidayID': holidayType,
      'leaveLimit': leaveDaysEntitlement,
      'medFeeLimit': medicalFeesEntitlement,
      'leaveUse': leaveDaysUsed,
      'medFeeUse': medicalFeesUsed,
    };
  }

  Employee.mockUp()
      : empCode = "test",
        userName = "test",
        firstName = "test",
        lastName = "test",
        nickName = "test",
        role = "test",
        holidayType = "test",
        leaveDaysEntitlement = 23.0,
        medicalFeesEntitlement = 1000.0,
        leaveDaysUsed = 0.0,
        medicalFeesUsed = 0.0;

  String get fullName => "$firstName $lastName";
  bool get isAdmin => role == "ADMIN";
}
