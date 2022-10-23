import 'package:currency_now/common/app_config.dart';
import 'package:currency_now/common/currencies_model.dart';
import 'package:currency_now/common/histories_model.dart';
import 'package:currency_now/core/app_exception.dart';
import 'package:currency_now/screens/choose_default_information/views/choose_default_information.dart';
import 'package:currency_now/screens/home_page/views/home_page.dart';
import 'package:currency_now/services/user_service.dart';
import 'package:currency_now/utils/toast_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class SplashScreenModel extends ChangeNotifier {
  final String env;
  SplashScreenModel({required this.env});
  bool hasError = false;
  bool isLoading = true;

  Future<void> init(BuildContext context) async {
    await Future.delayed(const Duration(milliseconds: 1500));

    ///Load app configuration
    final appConfig = Provider.of<AppConfig>(context, listen: false);
    await appConfig.fromConfiguration(context, env: env);

    await reload(context);
  }

  Future<void> reload(BuildContext context) async {
    try {
      hasError = false;
      isLoading = true;
      notifyListeners();

      final currenciesModel =
          Provider.of<CurrenciesModel>(context, listen: false);
      await currenciesModel.init(context);
      final historiesModel =
          Provider.of<HistoriesModel>(context, listen: false);
      await historiesModel.init(context);
      final userService = Provider.of<UserService>(context, listen: false);
      try {
        await userService.init();
        //If the user is found in local storage, go to home page
        HomePage.create(context);
      } catch (e) {
        //If the user is not found
        ChooseDefaultInformation.create(context);
      }
    } on AppException catch (e) {
      hasError = true;
      ToastUtils.show(context, e.message);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
