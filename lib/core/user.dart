import 'package:currency_now/core/currency.dart';

class User {
  String username;
  Currency from;
  Currency to;

  User({required this.username, required this.from, required this.to});

  factory User.fromMap(Map<String, dynamic> data) {
    return User(
        username: data['username'],
        from: Currency.fromMap(data['from']),
        to: Currency.fromMap(data['to']));
  }

  Map<String, dynamic> toMap() {
    return {
      "username": username,
      "from": from.toMap(),
      "to": to.toMap(),
    };
  }
}
