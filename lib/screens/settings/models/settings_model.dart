import 'package:currency_now/common/currencies_model.dart';
import 'package:currency_now/core/currency.dart';
import 'package:currency_now/services/user_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class SettingsModel extends ChangeNotifier {
  late Currency from;
  late Currency to;

  void init(BuildContext context,
      {required TextEditingController usernameController}) {
    final userService = Provider.of<UserService>(context, listen: false);

    from = userService.user.from;
    to = userService.user.to;
    usernameController.text = userService.user.username;
  }

  void onFromCurrencyChanged(BuildContext context, String? code) {
    if (code != null && from.code != code) {
      final currenciesModel =
          Provider.of<CurrenciesModel>(context, listen: false);

      from = currenciesModel.currencies
          .where((currency) => currency.code == code)
          .first;
      notifyListeners();
    }
  }

  void onToCurrencyChanged(BuildContext context, String? code) {
    if (code != null && to.code != code) {
      final currenciesModel =
          Provider.of<CurrenciesModel>(context, listen: false);

      to = currenciesModel.currencies
          .where((currency) => currency.code == code)
          .first;
      notifyListeners();
    }
  }

  void switchCurrencies() {
    Currency? temp = from;
    from = to;
    to = temp;
    notifyListeners();
  }

  Future<void> submit(BuildContext context, {required String username}) async {
    final userService = Provider.of<UserService>(context, listen: false);

    await userService.updateUser(username: username, from: from, to: to);
    Navigator.pop(context);
  }
}
