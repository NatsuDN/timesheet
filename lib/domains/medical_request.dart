class MedicalRequest {
  final String id;
  final String empId;
  final String orgId;
  final double amount;
  final String note;
  final String imgUrl;
  final DateTime date;
  final String medStatus;

  MedicalRequest({
    required this.id,
    required this.empId,
    required this.orgId,
    required this.amount,
    required this.note,
    required this.imgUrl,
    required this.date,
    required this.medStatus,
  });

  factory MedicalRequest.fromJson(Map<String, dynamic> json) {
    return MedicalRequest(
        id: json["medID"],
        empId: json["empID"],
        orgId: json["orgID"],
        imgUrl: json["slipPic"],
        amount: json["amount"],
        note: json["note"],
        date: DateTime.parse(json['date']),
        medStatus: json["medStatus"]);
  }
}
