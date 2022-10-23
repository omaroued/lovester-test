import 'package:currency_now/common/currencies_model.dart';
import 'package:currency_now/common/theme_model.dart';
import 'package:currency_now/screens/choose_default_information/models/choose_default_information_model.dart';
import 'package:currency_now/transitions/fade_route.dart';
import 'package:currency_now/utils/validators.dart';
import 'package:currency_now/widgets/buttons/default_button.dart';
import 'package:currency_now/widgets/default_drop_down.dart';
import 'package:currency_now/widgets/text_fields/default_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class ChooseDefaultInformation extends StatefulWidget {
  static void create(BuildContext context) {
    Navigator.pushReplacement(
        context,
        FadeRoute(
            page: ChangeNotifierProvider<ChooseDefaultInformationModel>(
          create: (context) => ChooseDefaultInformationModel(),
          child: Consumer<ChooseDefaultInformationModel>(
              builder: ((context, model, _) {
            return ChooseDefaultInformation._(model: model);
          })),
        )));
  }

  final ChooseDefaultInformationModel model;
  const ChooseDefaultInformation._({Key? key, required this.model})
      : super(key: key);

  @override
  State<ChooseDefaultInformation> createState() =>
      _ChooseDefaultInformationState();
}

class _ChooseDefaultInformationState extends State<ChooseDefaultInformation> {
  final usernameController = TextEditingController();

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

    return Scaffold(
      body: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (overscroll) {
            ///Remove listview glow
            overscroll.disallowIndicator();
            return true;
          },
          child: Form(
            key: _formKey,
            child: Center(
              child: ListView(
                  padding: MediaQuery.of(context)
                      .padding
                      .add(const EdgeInsets.all(20)),
                  shrinkWrap: true,
                  children: [
                    Center(
                      child: FadeInImage(
                          width: 200,
                          height: 200,
                          fit: BoxFit.contain,
                          placeholder: MemoryImage(kTransparentImage),
                          image: const AssetImage("assets/images/logo.png")),
                    ),

                    ///Username text field
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 30),
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
                                value: widget.model.from?.code,
                                hasError: !widget.model.validFrom,
                                items: currenciesModel.currencies
                                    .where((currency) =>
                                        currency.code != widget.model.to?.code)
                                    .map((e) => DropdownMenuItem(
                                          child: Text(e.name),
                                          value: e.code,
                                        ))
                                    .toList(),
                                hint: Center(
                                    child: Text(
                                  "From",
                                  style: themeModel.theme.textTheme.bodyText1
                                      ?.apply(
                                          color: themeModel.secondTextColor),
                                )),
                                selectedItemBuilder: (context) {
                                  return currenciesModel.currencies
                                      .where((currency) =>
                                          currency.code !=
                                          widget.model.to?.code)
                                      .map((e) => Center(
                                            child: Text(e.code),
                                          ))
                                      .toList();
                                },
                                onChanged: (value) {
                                  widget.model
                                      .onFromCurrencyChanged(context, value);
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
                                value: widget.model.to?.code,
                                hasError: !widget.model.validTo,
                                items: currenciesModel.currencies
                                    .where((currency) =>
                                        currency.code !=
                                        widget.model.from?.code)
                                    .map((e) => DropdownMenuItem(
                                          child: Text(e.name),
                                          value: e.code,
                                        ))
                                    .toList(),
                                hint: Center(
                                    child: Text(
                                  "To",
                                  style: themeModel.theme.textTheme.bodyText1
                                      ?.apply(
                                          color: themeModel.secondTextColor),
                                )),
                                selectedItemBuilder: (context) {
                                  return currenciesModel.currencies
                                      .where((currency) =>
                                          currency.code !=
                                          widget.model.from?.code)
                                      .map((e) => Center(
                                            child: Text(e.code),
                                          ))
                                      .toList();
                                },
                                onChanged: (value) {
                                  widget.model
                                      .onToCurrencyChanged(context, value);
                                })),
                      ],
                    ),

                    ///Submit button
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: DefaultButton(
                          child: const Text("Submit"),
                          onPressed: () {
                            final isFormValid =
                                _formKey.currentState!.validate();
                            final areCurrenciesValid =
                                widget.model.validateCurrencies();
                            if (isFormValid && areCurrenciesValid) {
                              widget.model.submit(context,
                                  username: usernameController.text);
                            }
                          }),
                    )
                  ]),
            ),
          )),
    );
  }
}
