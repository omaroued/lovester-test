import 'package:currency_now/core/currency.dart';

class Endpoints {
  Endpoints._();

  static String currencies(String apiKey) => "/currencies?api_key=$apiKey";

  static String fetchOne(Currency from, Currency to, String apiKey) =>
      "/fetch-one?from=${from.code}&to=${to.code}&api_key=$apiKey";
}
