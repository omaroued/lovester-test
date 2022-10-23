import 'package:currency_now/common/theme_model.dart';
import 'package:currency_now/core/history.dart';
import 'package:currency_now/screens/histories/views/history_details.dart';
import 'package:currency_now/widgets/bounce.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HistoryCard extends StatelessWidget {
  final History history;
  const HistoryCard({Key? key, required this.history}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeModel = Provider.of<ThemeModel>(context);
    return Bounce(
        onPressed: () {
          HistoryDetails.create(context, history: history);
        },
        child: Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                    blurRadius: 2,
                    offset: const Offset(1, 1),
                    color: themeModel.shadowColor),
              ],
              color: themeModel.backgroundColor),
          child: Column(
            children: [
              Row(
                children: [
                  Flexible(
                      child: Text(
                    history.from.code,
                    style: themeModel.theme.textTheme.headline2,
                  )),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Icon(Icons.keyboard_arrow_right_outlined),
                  ),
                  Flexible(
                      child: Text(
                    history.to.code,
                    style: themeModel.theme.textTheme.headline2,
                  )),
                ],
              ),
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: Text(
                  DateFormat("yyyy-MM-dd HH:mm").format(history.createdAt),
                  style: themeModel.theme.textTheme.caption,
                ),
              )
            ],
          ),
        ));
  }
}
