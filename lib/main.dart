import 'package:currency_now/common/app_config.dart';
import 'package:currency_now/common/currencies_model.dart';
import 'package:currency_now/common/histories_model.dart';
import 'package:currency_now/common/theme_model.dart';
import 'package:currency_now/screens/splash_screen/models/splash_screen_model.dart';
import 'package:currency_now/screens/splash_screen/views/splash_screen.dart';
import 'package:currency_now/services/currencies_service.dart';
import 'package:currency_now/services/user_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';

void main({String env = "dev"}) {
  //Show all log types only in debug and profile mode
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    if (!kReleaseMode) {
      debugPrint(
          '[${record.loggerName}] ${record.level.name}: ${record.time}\n${record.message} '
          '${record.object != null ? "\n" + record.object.toString() : ""}'
          '${record.error != null ? "\n" + record.error.toString() : ""}'
          '${record.stackTrace != null ? "\n" + record.stackTrace.toString() : ""}');
    }
  });
  runApp(MyApp(
    env: env,
  ));
}

class MyApp extends StatelessWidget {
  final String env;
  const MyApp({Key? key, required this.env}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (context) => ThemeModel(),
        ),
        Provider(
          create: (context) => AppConfig(),
        ),
        Provider(
          create: (context) => CurrenciesService(),
        ),
        Provider(
          create: (context) => UserService(),
        ),
        ChangeNotifierProvider(
          create: (context) => CurrenciesModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => HistoriesModel(),
        ),
      ],
      child: Consumer<ThemeModel>(builder: (context, model, _) {
        return MaterialApp(
          title: 'Currency Now',
          theme: model.theme,
          home: ChangeNotifierProvider<SplashScreenModel>(
            create: (context) => SplashScreenModel(env: env),
            child: Consumer<SplashScreenModel>(builder: ((context, model, _) {
              return SplashScreen(model: model);
            })),
          ),
        );
      }),
    );
  }
}
