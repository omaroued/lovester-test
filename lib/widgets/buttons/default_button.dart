import 'package:currency_now/common/theme_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class DefaultButton extends StatelessWidget {
  final Widget child;
  final void Function()? onPressed;
  final double height;
  final double? width;
  final Color? color;

  const DefaultButton(
      {Key? key,
      required this.child,
      required this.onPressed,
      this.height = 55,
        this.width,
      this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeModel = Provider.of<ThemeModel>(context);
    return SizedBox(
      height: height,
      width: width,
      child: TextButton(
        onPressed: onPressed,
        child: child,
        style: themeModel.theme.textButtonTheme.style?.copyWith(
            backgroundColor:
                color != null ? MaterialStateProperty.all(color) : null),
      ),
    );
  }
}
