import 'package:currency_now/core/currency.dart';

class History {
  final Currency from;
  final Currency to;
  final num originalValue;
    final num exchangedValue;

  final DateTime createdAt;

  History(
      {required this.from,
      required this.to,
      required this.originalValue,
      required this.exchangedValue,
      required this.createdAt});

  Map<String, dynamic> toMap() {
    return {
      "from": from.toMap(),
      "to": to.toMap(),
      "original_value": originalValue,
      "exchanged_value": exchangedValue,
      "createdAt": createdAt.toIso8601String()
    };
  }

  factory History.fromMap(Map<String, dynamic> data) {
    return History(
        from: Currency.fromMap(data['from']),
        to: Currency.fromMap(data['to']),
        originalValue: data['original_value'],
        exchangedValue: data['exchanged_value'],
        createdAt: DateTime.parse(data['createdAt']));
  }
}
