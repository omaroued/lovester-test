import 'package:currency_now/common/histories_model.dart';
import 'package:currency_now/screens/histories/cards/history_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Histories extends StatelessWidget {
  static void create(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const Histories._()));
  }

  const Histories._({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<HistoriesModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("My histories"),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: EdgeInsets.only(
          top: 20,
          left: MediaQuery.of(context).padding.left + 20,
          right: MediaQuery.of(context).padding.right + 20,
          bottom: MediaQuery.of(context).padding.bottom + 20,
        ),
        itemBuilder: (context, position) {
          return HistoryCard(history: model.histories[position]);
        },
        itemCount: model.histories.length,
      ),
    );
  }
}
