import 'dart:convert';

import 'package:currency_now/common/app_config.dart';
import 'package:currency_now/core/app_exception.dart';
import 'package:currency_now/core/currency.dart';
import 'package:currency_now/utils/api_base_helper.dart';
import 'package:currency_now/utils/endpoints.dart';
import 'package:flutter/cupertino.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';

class CurrenciesService {
  final _logger = Logger("Currencies service");

  Future<List<Currency>> getCurrencies(BuildContext context) async {
    try {
      final appConfig = Provider.of<AppConfig>(context, listen: false);
      final url = appConfig.apiBaseUrl + Endpoints.currencies(appConfig.apiKey);

      final response = await ApiBasehelper.get(url, logger: _logger);

      if (response.statusCode == 200) {
        Map<String, dynamic> body = json.decode(response.body)['currencies'];
        List<Currency> currencies = [];

        for (var key in body.keys) {
          currencies.add(Currency(code: key, name: body[key]));
        }
        return currencies;
      } else {
        throw AppException(message: "Can't get currencies");
      }
    } catch (e, stack) {
      throw AppException.formatServiceException(_logger, e, stack);
    }
  }

  Future<num> getRate(BuildContext context,
      {required Currency from, required Currency to}) async {
    try {
      final appConfig = Provider.of<AppConfig>(context, listen: false);
      final url =
          appConfig.apiBaseUrl + Endpoints.fetchOne(from, to, appConfig.apiKey);

      final response = await ApiBasehelper.get(url, logger: _logger);

      if (response.statusCode == 200) {
        Map<String, dynamic> body = json.decode(response.body);

        return body['result'][to.code];
      } else {
        throw AppException(message: "Can't get currency rate");
      }
    } catch (e, stack) {
      throw AppException.formatServiceException(_logger, e, stack);
    }
  }
}
