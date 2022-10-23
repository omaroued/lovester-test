import 'package:currency_now/common/theme_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class ToastUtils{
  ToastUtils._();


  static void show(BuildContext context,String message){
    final themeModel=Provider.of<ThemeModel>(context,listen: false);

    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor:const Color(0xFFFFEDD5),
        textColor: themeModel.accentColor,
        fontSize: 16.0);
  }
}