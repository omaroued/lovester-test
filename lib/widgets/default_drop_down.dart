import 'package:currency_now/common/theme_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DefaultDropDown<T> extends StatelessWidget {
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?>? onChanged;
  final DropdownButtonBuilder? selectedItemBuilder;
  final Widget? hint;
  final bool hasError;
  const DefaultDropDown(
      {Key? key,
      required this.value,
      required this.items,
      required this.onChanged,
       this.hasError=false,
      this.hint,
      this.selectedItemBuilder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeModel = Provider.of<ThemeModel>(context);
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color:hasError? Colors.red: themeModel.secondTextColor, width: 1)),
      child: DropdownButton<T>(
        isExpanded: true,
        hint: hint,
        value: value,
        items: items,
        onChanged: onChanged,
        selectedItemBuilder: selectedItemBuilder,
        underline: const SizedBox(),
      ),
    );
  }
}
