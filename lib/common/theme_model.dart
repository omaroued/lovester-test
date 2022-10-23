import 'package:flutter/material.dart';

class ThemeModel {
  final Color backgroundColor = Colors.white;

  final Color secondBackgroundColor = const Color(0xFFF8F8F8);
  final Color textColor = Colors.black;
  final Color secondTextColor = Colors.grey;

  final Color shadowColor = Colors.black.withOpacity(0.07);
  final Color accentColor = Colors.blue;

  final MaterialColor swatch = Colors.blue;

  late final ThemeData theme;

  ThemeModel() {
    const String _fontFamily = "Baloo2";

    theme = ThemeData(
      brightness: Brightness.light,
      dialogBackgroundColor: backgroundColor,
      primarySwatch: swatch,
      backgroundColor: backgroundColor,
      scaffoldBackgroundColor: backgroundColor,
      colorScheme: ColorScheme.fromSwatch(
              primarySwatch: swatch, brightness: Brightness.light)
          .copyWith(secondary: accentColor),
      bottomSheetTheme:
          const BottomSheetThemeData(backgroundColor: Colors.transparent),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: backgroundColor,
        selectedItemColor: accentColor,
      ),
      tabBarTheme: TabBarTheme(
        labelColor: backgroundColor,
        unselectedLabelStyle: const TextStyle(
          fontFamily: _fontFamily,
          fontWeight: FontWeight.w400,
          fontSize: 15,
        ),
        labelStyle: const TextStyle(
          fontFamily: _fontFamily,
          fontWeight: FontWeight.w400,
          fontSize: 15,
        ),
      ),
      appBarTheme: AppBarTheme(
          backgroundColor: accentColor,
          titleTextStyle: const TextStyle(
            fontFamily: _fontFamily,
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          )),
      textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all(Colors.white),
              elevation: MaterialStateProperty.all<double>(2.5),
              textStyle: MaterialStateProperty.all<TextStyle>(const TextStyle(
                fontFamily: _fontFamily,
                fontWeight: FontWeight.w700,
                fontSize: 16,
                color: Colors.white,
              )),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              )),
              backgroundColor: MaterialStateProperty.all(accentColor))),
      iconTheme: IconThemeData(
        color: secondTextColor,
      ),
      textTheme: TextTheme(
          headline1: TextStyle(
              fontFamily: _fontFamily,
              fontWeight: FontWeight.w600,
              fontSize: 22,
              color: textColor),
          headline2: TextStyle(
              fontFamily: _fontFamily,
              fontWeight: FontWeight.w700,
              fontSize: 20,
              color: textColor),
          headline3: TextStyle(
              fontFamily: _fontFamily,
              fontWeight: FontWeight.w700,
              fontSize: 16,
              color: textColor),
          headline4: TextStyle(
              fontFamily: _fontFamily,
              fontWeight: FontWeight.w700,
              fontSize: 14,
              color: textColor),
          headline5: TextStyle(
              fontFamily: _fontFamily,
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: textColor),
          headline6: TextStyle(
              fontFamily: _fontFamily,
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: textColor),
          bodyText1: TextStyle(
              fontFamily: _fontFamily,
              fontWeight: FontWeight.w400,
              fontSize: 13,
              color: textColor),
          bodyText2: TextStyle(
              fontFamily: _fontFamily,
              fontWeight: FontWeight.w400,
              fontSize: 13,
              color: textColor),
          subtitle1: TextStyle(
              fontFamily: _fontFamily,
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: textColor),
          subtitle2: TextStyle(
              fontFamily: _fontFamily,
              fontWeight: FontWeight.w500,
              fontSize: 12,
              color: textColor),
          caption: TextStyle(
              fontFamily: _fontFamily,
              fontWeight: FontWeight.w400,
              fontSize: 12,
              color: secondTextColor)),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
        fillColor: accentColor.withOpacity(0.07),
        labelStyle: TextStyle(
          fontFamily: _fontFamily,
          fontSize: 12,
          color: secondTextColor,
        ),
        hintStyle: TextStyle(
          fontFamily: _fontFamily,
          fontSize: 12,
          color: secondTextColor,
        ),
      ),
    );
  }
}
