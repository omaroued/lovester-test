import 'package:currency_now/core/currency.dart';
import 'package:currency_now/services/currencies_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class CurrenciesModel extends ChangeNotifier {
  List<Currency> currencies = [];

  Future<void> init(BuildContext context) async {
    final currenciesService =
        Provider.of<CurrenciesService>(context, listen: false);
    currencies = await currenciesService.getCurrencies(context);
  }
}
