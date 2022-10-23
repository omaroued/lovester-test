import 'package:currency_now/common/theme_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DefaultOutlinedButton extends StatelessWidget {
  final bool withUnderline;
  final Widget child;
  final void Function() onPressed;
  final double height;
  final Color? color;

  const DefaultOutlinedButton(
      {Key? key,
      required this.child,
      required this.onPressed,
      this.height = 55,
      this.withUnderline = true,
      this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeModel = Provider.of<ThemeModel>(context);

    return SizedBox(
      height: height,
      child: TextButton(
          style: themeModel.theme.textButtonTheme.style!.copyWith(
              foregroundColor: MaterialStateProperty.all<Color>(
                  color ?? themeModel.secondTextColor),
              backgroundColor: MaterialStateProperty.all(Colors.white),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                  side: BorderSide(
                      color: color ?? themeModel.secondTextColor, width: 2))),
              textStyle: MaterialStateProperty.all(
                  themeModel.theme.textTheme.headline3!.apply(
                decoration: withUnderline
                    ? TextDecoration.underline
                    : TextDecoration.none,
              )),
              elevation: MaterialStateProperty.all(0)),
          onPressed: onPressed,
          child: child,
        ),
    );
  }
}
