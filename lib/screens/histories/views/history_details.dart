import 'package:currency_now/common/theme_model.dart';
import 'package:currency_now/core/history.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HistoryDetails extends StatelessWidget {
  static void create(BuildContext context, {required History history}) {
    showDialog(
        context: context,
        builder: (context) => HistoryDetails._(history: history));
  }

  final History history;
  const HistoryDetails._({Key? key, required this.history}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeModel = Provider.of<ThemeModel>(context);
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: themeModel.backgroundColor,
        ),
        child: Wrap(
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
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child:
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Expanded(
                    child: Text(
                  history.from.name,
                  style: themeModel.theme.textTheme.headline4,
                )),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Icon(Icons.keyboard_arrow_right_outlined),
                ),
                Expanded(
                    child: Text(
                  history.to.name,
                  style: themeModel.theme.textTheme.headline4,
                )),
              ]),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30, bottom: 10),
              child:
                  Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                Expanded(
                    child: Center(
                  child: Text(
                    history.originalValue.toString() + " " + history.from.code,
                    style: themeModel.theme.textTheme.headline4,
                  ),
                )),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Icon(FontAwesomeIcons.equals),
                ),
                Expanded(
                    child: Center(
                  child: Text(
                    history.exchangedValue.toString() + " " + history.to.code,
                    style: themeModel.theme.textTheme.headline4
                        ?.apply(color: themeModel.accentColor),
                  ),
                )),
              ]),
            ),
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: Text(
                "Saved at: " +
                    DateFormat("yyyy-MM-dd HH:mm").format(history.createdAt),
                style: themeModel.theme.textTheme.caption,
              ),
            )
          ],
        ),
      ),
    );
  }
}
