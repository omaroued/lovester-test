import 'package:currency_now/common/currencies_model.dart';
import 'package:currency_now/core/currency.dart';
import 'package:currency_now/screens/home_page/views/home_page.dart';
import 'package:currency_now/services/user_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class ChooseDefaultInformationModel extends ChangeNotifier {
  bool isLoading = true;
  Currency? from;
  Currency? to;

  bool validFrom = true;
  bool validTo = true;

  void switchCurrencies() {
    Currency? temp = from;
    from = to;
    to = temp;
    notifyListeners();
  }

  bool validateCurrencies() {
    bool result = true;
    if (from == null) {
      validFrom = false;
      result = false;
    } else {
      validFrom = true;
    }

    if (to == null) {
      validTo = false;
      result = false;
    } else {
      validTo = true;
    }

    if (!result) {
      notifyListeners();
    }
    return result;
  }

  void onFromCurrencyChanged(BuildContext context, String? code) {
    if (code != null && from?.code != code) {
      final currenciesModel =
          Provider.of<CurrenciesModel>(context, listen: false);

      from = currenciesModel.currencies
          .where((currency) => currency.code == code)
          .first;
      notifyListeners();
    }
  }

  void onToCurrencyChanged(BuildContext context, String? code) {
    if (code != null && to?.code != code) {
      final currenciesModel =
          Provider.of<CurrenciesModel>(context, listen: false);

      to = currenciesModel.currencies
          .where((currency) => currency.code == code)
          .first;
      notifyListeners();
    }
  }

  Future<void> submit(BuildContext context, {required String username}) async {
    final userService = Provider.of<UserService>(context, listen: false);

    await userService.addUser(username: username, from: from!, to: to!);

    HomePage.create(context);
  }
}
