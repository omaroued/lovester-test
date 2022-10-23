import 'package:currency_now/common/currencies_model.dart';
import 'package:currency_now/core/app_exception.dart';
import 'package:currency_now/core/currency.dart';
import 'package:currency_now/services/currencies_service.dart';
import 'package:currency_now/services/user_service.dart';
import 'package:currency_now/utils/toast_utils.dart';
import 'package:currency_now/widgets/dialogs/loading_dialog.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class HomePageModel extends ChangeNotifier {
  late Currency from;
  late Currency to;
  num rate = 0;

  void onFromFieldChanged(String value, TextEditingController controller) {
    ///When we change "from" textfield, we update "to" textfield
    if (value.isEmpty) {
      controller.text = "";
    } else if (num.tryParse(value) != null) {
      controller.text = (Decimal.parse(value) * Decimal.parse(rate.toString()))
          .toDouble()
          .toString();
    }
    notifyListeners();
  }

  void onToFieldChanged(String value, TextEditingController controller) {
    ///When we change "to" textfield, we update "from" textfield
    if (value.isEmpty) {
      controller.text = "";
    } else if (num.tryParse(value) != null) {
      controller.text = (Decimal.parse(value) / Decimal.parse(rate.toString()))
          .toDouble()
          .toString();
    }
    notifyListeners();
  }

  void init(BuildContext context) {
    ///On start, we collect the user "from" and "to" currencies
    final userService = Provider.of<UserService>(context, listen: false);
    from = userService.user.from;
    to = userService.user.to;

    ///Then we load the rate
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      getRate(context);
    });
  }

  Future<void> getRate(BuildContext context) async {
    try {
      ///Showing loading dialog
      LoadingDialog.create(context);

      ///Loading currency
      final currenciesService =
          Provider.of<CurrenciesService>(context, listen: false);

      rate = await currenciesService.getRate(context, from: from, to: to);
    } on AppException catch (e) {
      ///If there is a error we show a toast message
      ToastUtils.show(context, e.message);
    } finally {
      Navigator.pop(context);
    }
  }

  void switchCurrencies({
    required TextEditingController fromController,
    required TextEditingController toController,
  }) {
    ///When we switch the currencies the new rate will be equal to 1/rate
    Currency? temp = from;
    from = to;
    to = temp;
    rate = (Decimal.one / Decimal.parse(rate.toString())).toDouble();

    ///We switch textfield values
    String copy = fromController.text;
    fromController.text = toController.text;
    toController.text = copy;
    notifyListeners();
  }

  void onFromCurrencyChanged(
    BuildContext context, {
    String? code,
    required TextEditingController fromController,
    required TextEditingController toController,
  }) {
    if (code != null && from.code != code) {
      final currenciesModel =
          Provider.of<CurrenciesModel>(context, listen: false);
      from = currenciesModel.currencies
          .where((currency) => currency.code == code)
          .first;

      ///When we change the currency, we load the new rate
      getRate(context);

      ///Then we change the "to" textfield value
      if (fromController.text.isNotEmpty) {
        toController.text = (Decimal.parse(fromController.text) *
                Decimal.parse(rate.toString()))
            .toDouble()
            .toString();
      }
      notifyListeners();
    }
  }

  void onToCurrencyChanged(
    BuildContext context, {
    String? code,
    required TextEditingController fromController,
    required TextEditingController toController,
  }) {
    if (code != null && to.code != code) {
      final currenciesModel =
          Provider.of<CurrenciesModel>(context, listen: false);
      to = currenciesModel.currencies
          .where((currency) => currency.code == code)
          .first;

      ///When we change the currency, we load the new rate

      getRate(context);

      ///Then we change the "to" textfield value
      if (toController.text.isNotEmpty) {
        fromController.text =
            (Decimal.parse(toController.text) * Decimal.parse(rate.toString()))
                .toDouble()
                .toString();
      }
      notifyListeners();
    }
  }
}
