import 'package:currency_now/common/theme_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class DefaultTextField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode? focusNode;
  final bool isLoading;
  final bool? enabled;
  final TextCapitalization textCapitalization;
  final TextInputAction textInputAction;
  final String? labelText;
  final String? hintText;
  final TextInputType keyboardType;
  final bool obscureText;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLines;
  final int? minLines;
  final Widget? suffixIcon;
  final Widget? icon;
  final InputBorder? border;
  final TextAlign? textAlign;
  final EdgeInsetsGeometry? contentPadding;
  final void Function(String)? onChanged;

  final void Function(String)? onSubmitted;
  final void Function()? onTap;
  final String? Function(String?)? validator;

  const DefaultTextField(
      {Key? key,
      required this.controller,
      this.focusNode,
      this.isLoading = false,
      required this.textCapitalization,
      required this.textInputAction,
      this.labelText,
      required this.keyboardType,
      this.obscureText = false,
      this.inputFormatters,
       this.validator,
      this.maxLines = 1,
      this.minLines,
      this.suffixIcon,
      this.onSubmitted,
        this.onChanged,
      this.onTap,
      this.hintText,
      this.icon,
      this.enabled,
      this.border,
      this.textAlign,
      this.contentPadding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeModel = Provider.of<ThemeModel>(context);

    return TextFormField(
      obscureText: obscureText,
      focusNode: focusNode,
      textAlign: textAlign ?? TextAlign.start,
      enabled: enabled ?? !isLoading,
      validator: validator,
      controller: controller,
      keyboardType: keyboardType,
      textCapitalization: textCapitalization,
      textInputAction: textInputAction,
      inputFormatters: inputFormatters,
      maxLines: maxLines,
      minLines: minLines,
      onTap: onTap,
      onChanged: onChanged,
      onFieldSubmitted: onSubmitted,
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
          enabledBorder: border,
          contentPadding: contentPadding,
          focusedBorder: border,
          filled: (focusNode?.hasFocus ?? false) ? true : false,
          prefixIcon: icon,
          hintStyle: themeModel.theme.textTheme.headline6!
              .apply(color: themeModel.secondTextColor),
          labelStyle: themeModel.theme.textTheme.headline6,
          labelText: labelText,
          hintText: hintText,
          suffixIcon: suffixIcon),
    );
  }
}
