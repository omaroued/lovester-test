import 'dart:convert';

import 'package:currency_now/core/app_exception.dart';
import 'package:currency_now/core/currency.dart';
import 'package:currency_now/core/history.dart';
import 'package:currency_now/core/user.dart';
import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  final _logger = Logger("User service");

  late User user;

  Future<void> init() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      if (prefs.containsKey("user")) {
        user = User.fromMap(json.decode(prefs.getString("user")!));
        await prefs.setString("user", json.encode(user.toMap()));
      } else {
        throw AppException(message: "User not found!");
      }
    } catch (e, stack) {
      throw AppException.formatServiceException(_logger, e, stack);
    }
  }

  Future<void> addUser(
      {required String username,
      required Currency from,
      required Currency to}) async {
    final prefs = await SharedPreferences.getInstance();
    user = User(username: username, from: from, to: to);
    await prefs.setString("user", json.encode(user.toMap()));
  }

  Future<void> updateUser(
      {String? username, Currency? from, Currency? to}) async {
    final prefs = await SharedPreferences.getInstance();
    if (username != null) {
      user.username = username;
    }
    if (from != null) {
      user.from = from;
    }
    if (to != null) {
      user.to = to;
    }
    await prefs.setString("user", json.encode(user.toMap()));
  }

  Future<List<History>> getHistories() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("histories")) {
      return List.from(json.decode(prefs.getString("histories")!))
          .map((e) => History.fromMap(e))
          .toList();
    }
    return [];
  }

  Future<void> saveHistories(List<History> histories) async {
    final prefs = await SharedPreferences.getInstance();
    List<Map<String, dynamic>> mappedHistories =
        histories.map((history) => history.toMap()).toList();
    await prefs.setString("histories", json.encode(mappedHistories));
  }
}
