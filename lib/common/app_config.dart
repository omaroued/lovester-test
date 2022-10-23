import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:logging/logging.dart';

class AppConfig {
  late final String appName;
  late final String flavorName;
  late final String apiBaseUrl;
  late final String apiKey;

  AppConfig();

  Future<void> fromConfiguration(BuildContext context,
      {required String env}) async {
    Map<String, dynamic> data = json.decode(await DefaultAssetBundle.of(context)
        .loadString("assets/configs/$env.json"));

    appName = data['app_name'];
    flavorName = data['flavor_name'];
    apiBaseUrl = data['api_base_url'];
    apiKey = data['api_key'];

    final _log = Logger('App config');
    _log.info("Environment: $flavorName");
    _log.info("API: $apiBaseUrl");
  }
}
