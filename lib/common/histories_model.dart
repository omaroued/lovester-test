import 'package:currency_now/core/currency.dart';
import 'package:currency_now/core/history.dart';
import 'package:currency_now/services/user_service.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class HistoriesModel extends ChangeNotifier {
  List<History> histories = [];

  Future<void> init(BuildContext context) async {
    final userService = Provider.of<UserService>(context, listen: false);
    histories = await userService.getHistories();
  }

  bool isAddedToHistories(Currency from, Currency to, String value) => histories
      .where((history) =>
          history.from.code == from.code &&
          history.to.code == to.code &&
          history.originalValue == num.tryParse(value))
      .isNotEmpty;

  Future<void> addHistory(BuildContext context,
      {required Currency from,
      required Currency to,
      required num value,
      required num rate}) async {
    histories.add(History(
        from: from,
        to: to,
        exchangedValue: num.parse(
            (Decimal.parse(value.toString()) * Decimal.parse(rate.toString()))
                .toDouble()
                .toString()),
        originalValue: value,
        createdAt: DateTime.now()));

    final userService = Provider.of<UserService>(context, listen: false);
    await userService.saveHistories(histories);
    notifyListeners();
  }

  Future<void> removeHistory(
    BuildContext context, {
    required Currency from,
    required Currency to,
    required num value,
  }) async {
    histories.removeWhere((history) =>
        history.from.code == from.code &&
        history.to.code == to.code &&
        history.originalValue == value);

    final userService = Provider.of<UserService>(context, listen: false);
    await userService.saveHistories(histories);
    notifyListeners();
  }
}
