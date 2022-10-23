import 'package:currency_now/common/currencies_model.dart';
import 'package:currency_now/common/theme_model.dart';
import 'package:currency_now/screens/settings/models/settings_model.dart';
import 'package:currency_now/utils/validators.dart';
import 'package:currency_now/widgets/buttons/default_button.dart';
import 'package:currency_now/widgets/default_drop_down.dart';
import 'package:currency_now/widgets/text_fields/default_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget {
  static void create(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => ChangeNotifierProvider<SettingsModel>(
              create: (context) => SettingsModel(),
              child: Consumer<SettingsModel>(
                builder: ((context, model, child) {
                  return Settings._(model: model);
                }),
              ),
            ));
  }

  final SettingsModel model;
  const Settings._({Key? key, required this.model}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final usernameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    widget.model.init(context, usernameController: usernameController);
  }

  @override
  void dispose() {
    super.dispose();
    usernameController.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final themeModel = Provider.of<ThemeModel>(context);
    final currenciesModel = Provider.of<CurrenciesModel>(context);
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
            color: themeModel.backgroundColor,
            borderRadius: BorderRadius.circular(5)),
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(10),
            shrinkWrap: true,
            children: [
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(Icons.clear),
                ),
              ),

              ///Username text field
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 20),
                child: DefaultTextField(
                    controller: usernameController,
                    textCapitalization: TextCapitalization.none,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.text,
                    hintText: "Username",
                    validator: (value) {
                      if (value != null && Validators.username(value)) {
                        return null;
                      }
                      return "Please enter a valid username";
                    }),
              ),

              ///Currencies selector
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
                            widget.model.onFromCurrencyChanged(context, value);
                          })),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: IconButton(
                        onPressed: () {
                          widget.model.switchCurrencies();
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
                            widget.model.onToCurrencyChanged(context, value);
                          })),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: DefaultButton(
                    child: const Text("Update"),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        widget.model
                            .submit(context, username: usernameController.text);
                      }
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
