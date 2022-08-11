class Company {
  final String name;
  final String? logoUrl;
  final String id;

  Company({
    required this.name,
    required this.id,
    this.logoUrl,
  });

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      name: json['orgNameEng'],
      logoUrl: json['logoUrl'],
      id: json['orgID'] ?? 'error',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'orgNameEng': name,
      'logoUrl': logoUrl,
      'orgID': id,
    };
  }

  Company.mockUp()
      : name = "Test Company",
        id = "TestCompany",
        logoUrl = null;
}
