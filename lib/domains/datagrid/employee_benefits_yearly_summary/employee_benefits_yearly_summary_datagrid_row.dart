import 'package:pluto_grid/pluto_grid.dart';

class EmployeeBenefitsYearlySummary {
  final String empId,
      empCode,
      nickName,
      total,
      jan,
      feb,
      mar,
      apr,
      may,
      jun,
      jul,
      aug,
      sep,
      oct,
      nov,
      dec;

  EmployeeBenefitsYearlySummary({
    required this.empId,
    required this.empCode,
    required this.nickName,
    required this.total,
    required this.jan,
    required this.feb,
    required this.mar,
    required this.apr,
    required this.may,
    required this.jun,
    required this.jul,
    required this.aug,
    required this.sep,
    required this.oct,
    required this.nov,
    required this.dec,
  });

  EmployeeBenefitsYearlySummary.fromJsonByEmpId(Map<String, dynamic> json,
      {required this.empId})
      : empCode = json['empCode'] ?? 'error',
        nickName = json['nickName'] as String,
        total = json['total'].toString(),
        jan = json['jan'].toString(),
        feb = json['feb'].toString(),
        mar = json['mar'].toString(),
        apr = json['apr'].toString(),
        may = json['may'].toString(),
        jun = json['jun'].toString(),
        jul = json['jul'].toString(),
        aug = json['aug'].toString(),
        sep = json['sep'].toString(),
        oct = json['oct'].toString(),
        nov = json['nov'].toString(),
        dec = json['dec'].toString();

  EmployeeBenefitsYearlySummary.header(
      {required String year, required String totalTitle})
      : this(
          empId: '',
          empCode: '',
          nickName: '',
          total: totalTitle,
          jan: 'Jan $year',
          feb: 'Feb $year',
          mar: 'Mar $year',
          apr: 'Apr $year',
          may: 'May $year',
          jun: 'Jun $year',
          jul: 'Jul $year',
          aug: 'Aug $year',
          sep: 'Sep $year',
          oct: 'Oct $year',
          nov: 'Nov $year',
          dec: 'Dec $year',
        );

  EmployeeBenefitsYearlySummary.mockUp()
      : this(
          empId: '',
          empCode: 'test',
          nickName: 'test',
          total: '0',
          jan: '0',
          feb: '0',
          mar: '0',
          apr: '0',
          may: '0',
          jun: '0',
          jul: '0',
          aug: '0',
          sep: '0',
          oct: '0',
          nov: '0',
          dec: '0',
        );

  PlutoRow get plutoRow {
    return PlutoRow(cells: {
      'empId': PlutoCell(value: empId),
      'empCode': PlutoCell(value: empCode),
      'nickName': PlutoCell(value: nickName),
      'total': PlutoCell(value: total),
      'jan': PlutoCell(value: jan),
      'feb': PlutoCell(value: feb),
      'mar': PlutoCell(value: mar),
      'apr': PlutoCell(value: apr),
      'may': PlutoCell(value: may),
      'jun': PlutoCell(value: jun),
      'jul': PlutoCell(value: jul),
      'aug': PlutoCell(value: aug),
      'sep': PlutoCell(value: sep),
      'oct': PlutoCell(value: oct),
      'nov': PlutoCell(value: nov),
      'dec': PlutoCell(value: dec),
    });
  }
}
