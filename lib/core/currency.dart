class Currency {
  final String code;
  final String name;

  Currency({required this.code, required this.name});

  factory Currency.fromMap(Map<String, dynamic> data) {
    return Currency(code: data['code'], name: data['name']);
  }

  Map<String, String> toMap() {
    return {"code": code, "name": name};
  }
}
