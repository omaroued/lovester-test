import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:currency_now/common/theme_model.dart';
import 'package:currency_now/widgets/buttons/default_outlined_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class LoadingDialog extends StatelessWidget {
  static Future<bool?> create(BuildContext context, {bool canCancel = false}) {
    return showDialog(
        context: context,
        builder: (context) => LoadingDialog._(
              canCancel: canCancel,
            ),
        barrierDismissible: false);
  }

  final bool canCancel;

  const LoadingDialog._({Key? key, required this.canCancel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeModel = Provider.of<ThemeModel>(context);
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: AlertDialog(
        content: Row(
          children: [
            Platform.isIOS
                ? const CupertinoActivityIndicator()
                : const CircularProgressIndicator(),
            const Spacer(),
            Padding(
                padding: const EdgeInsets.only(left: 5, right: 5),
                child: Text(
                    "Loading...",
                  style: themeModel.theme.textTheme.headline4,
                )),
            const Spacer(),
          ],
        ),
        actionsAlignment: MainAxisAlignment.center,
        contentPadding: EdgeInsets.only(
            left: 20, right: 20, top: 20, bottom: canCancel ? 10 : 20),
        actions: canCancel
            ? [
                SizedBox(
                  width: 150,
                  child: DefaultOutlinedButton(
                      height: 40,
                      child: const AutoSizeText(
                         "Cancel wait"),
                      onPressed: () {
                        Navigator.pop(context, true);
                      }),
                )
              ]
            : null,
      ),
    );
  }
}
