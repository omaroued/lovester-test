import 'package:currency_now/common/currencies_model.dart';
import 'package:currency_now/common/histories_model.dart';
import 'package:currency_now/common/theme_model.dart';
import 'package:currency_now/screens/histories/views/histories.dart';
import 'package:currency_now/screens/home_page/models/home_page_model.dart';
import 'package:currency_now/screens/settings/views/settings.dart';
import 'package:currency_now/transitions/fade_route.dart';
import 'package:currency_now/widgets/buttons/default_button.dart';
import 'package:currency_now/widgets/default_drop_down.dart';
import 'package:currency_now/widgets/text_fields/default_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class HomePage extends StatefulWidget {
  static void create(BuildContext context) {
    Navigator.pushReplacement(
        context,
        FadeRoute(
            page: ChangeNotifierProvider<HomePageModel>(
          create: (context) => HomePageModel(),
          child: Consumer<HomePageModel>(builder: ((context, model, _) {
            return HomePage._(model: model);
          })),
        )));
  }

  final HomePageModel model;
  const HomePage._({Key? key, required this.model}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final fromController = TextEditingController();
  final toController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    fromController.dispose();
    toController.dispose();
  }

  @override
  void initState() {
    super.initState();
    widget.model.init(context);
  }

  @override
  Widget build(BuildContext context) {
    final themeModel = Provider.of<ThemeModel>(context);
    final currenciesModel = Provider.of<CurrenciesModel>(context);
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        padding: MediaQuery.of(context).padding.add(
            const EdgeInsetsDirectional.only(
                top: 4, end: 4, start: 20, bottom: 20)),
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FadeInImage(
                placeholder: MemoryImage(kTransparentImage),
                image: const AssetImage("assets/images/logo.png"),
                width: 50,
                height: 50,
              ),
              const Spacer(),
              IconButton(
                  onPressed: () {
                    Histories.create(context);
                  },
                  icon: Icon(
                    FontAwesomeIcons.database,
                    color: themeModel.accentColor,
                  )),
              IconButton(
                  onPressed: () {
                    Settings.create(context);
                  },
                  icon: Icon(
                    Icons.settings,
                    color: themeModel.accentColor,
                  ))
            ],
          ),
          Padding(
            padding: const EdgeInsetsDirectional.only(end: 16, top: 30),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                        child: DefaultDropDown<String>(
                            value: widget.model.from.code,
                            items: currenciesModel.currencies
                                .where((currency) =>
                                    currency.code != widget.model.to.code)
                                .map((e) => DropdownMenuItem(
                                      child: Text(e.name),
                                      value: e.code,
                                    ))
                                .toList(),
                            hint: Center(
                                child: Text(
                              "From",
                              style: themeModel.theme.textTheme.bodyText1
                                  ?.apply(color: themeModel.secondTextColor),
                            )),
                            selectedItemBuilder: (context) {
                              return currenciesModel.currencies
                                  .where((currency) =>
                                      currency.code != widget.model.to.code)
                                  .map((e) => Center(
                                        child: Text(e.code),
                                      ))
                                  .toList();
                            },
                            onChanged: (value) {
                              widget.model.onFromCurrencyChanged(context,
                                  code: value,
                                  fromController: fromController,
                                  toController: toController);
                            })),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: IconButton(
                          onPressed: () {
                            widget.model.switchCurrencies(
                                fromController: fromController,
                                toController: toController);
                          },
                          icon: Icon(
                            Icons.repeat,
                            color: themeModel.accentColor,
                            size: 30,
                          )),
                    ),
                    Flexible(
                        child: DefaultDropDown<String>(
                            value: widget.model.to.code,
                            items: currenciesModel.currencies
                                .where((currency) =>
                                    currency.code != widget.model.from.code)
                                .map((e) => DropdownMenuItem(
                                      child: Text(e.name),
                                      value: e.code,
                                    ))
                                .toList(),
                            hint: Center(
                                child: Text(
                              "To",
                              style: themeModel.theme.textTheme.bodyText1
                                  ?.apply(color: themeModel.secondTextColor),
                            )),
                            selectedItemBuilder: (context) {
                              return currenciesModel.currencies
                                  .where((currency) =>
                                      currency.code != widget.model.from.code)
                                  .map((e) => Center(
                                        child: Text(e.code),
                                      ))
                                  .toList();
                            },
                            onChanged: (value) {
                              widget.model.onToCurrencyChanged(context,
                                  code: value,
                                  fromController: fromController,
                                  toController: toController);
                            })),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30, bottom: 20),
                  child: DefaultTextField(
                    textAlign: TextAlign.center,
                    controller: fromController,
                    textCapitalization: TextCapitalization.none,
                    onChanged: (value) {
                      widget.model.onFromFieldChanged(value, toController);
                    },
                    textInputAction: TextInputAction.done,
                    hintText: widget.model.from.name,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
                      TextInputFormatter.withFunction((oldValue, newValue) {
                        if (newValue.text.isEmpty) {
                          return newValue;
                        } else if (num.tryParse(newValue.text) != null) {
                          return newValue;
                        }
                        return oldValue;
                      }),
                    ],
                  ),
                ),
                DefaultTextField(
                  textAlign: TextAlign.center,
                  controller: toController,
                  textCapitalization: TextCapitalization.none,
                  textInputAction: TextInputAction.done,
                  hintText: widget.model.to.name,
                  onChanged: (value) {
                    widget.model.onToFieldChanged(value, fromController);
                  },
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
                    TextInputFormatter.withFunction((oldValue, newValue) {
                      if (newValue.text.isEmpty) {
                        return newValue;
                      } else if (num.tryParse(newValue.text) != null) {
                        return newValue;
                      }
                      return oldValue;
                    }),
                  ],
                ),
                if (fromController.text.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 30, bottom: 10),
                    child: Consumer<HistoriesModel>(
                        builder: ((context, model, child) {
                      return model.isAddedToHistories(widget.model.from,
                              widget.model.to, fromController.text)
                          ? DefaultButton(
                              width: double.infinity,
                              child: Wrap(
                                crossAxisAlignment: WrapCrossAlignment.center,
                                alignment: WrapAlignment.center,
                                children: const [
                                  Icon(Icons.delete),
                                  Padding(
                                    padding:
                                        EdgeInsetsDirectional.only(start: 10),
                                    child: Text("Delete"),
                                  )
                                ],
                              ),
                              onPressed: () {
                                model.removeHistory(context,
                                    from: widget.model.from,
                                    to: widget.model.to,
                                    value: num.parse(fromController.text));
                              },
                              color: Colors.red,
                            )
                          : DefaultButton(
                              width: double.infinity,
                              child: Wrap(
                                crossAxisAlignment: WrapCrossAlignment.center,
                                alignment: WrapAlignment.center,
                                children: const [
                                  Icon(Icons.save),
                                  Padding(
                                    padding:
                                        EdgeInsetsDirectional.only(start: 10),
                                    child: Text("Save"),
                                  )
                                ],
                              ),
                              onPressed: () {
                                model.addHistory(context,
                                    from: widget.model.from,
                                    to: widget.model.to,
                                    value: num.parse(fromController.text),
                                    rate: widget.model.rate);
                              },
                              color: Colors.green,
                            );
                    })),
                  )
              ],
            ),
          )
        ],
      ),
    );
  }
}
