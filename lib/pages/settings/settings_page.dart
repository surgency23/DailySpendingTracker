import 'package:daily_spending_tracker/controllers/number_controllers/numbers_controller.dart';
import 'package:daily_spending_tracker/widgets/custom_app_bar.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppBar(),
        //put in fields to set values of the numbers
        body: Container(
            padding: const EdgeInsets.all(40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Consumer<NumbersController>(
                  builder: (context, NumbersController numbersNotifier,
                      Widget? child) {
                    return TextField(
                      decoration:
                          const InputDecoration(labelText: "Enter Value"),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^\d+\.?\d{0,2}')),
                      ], // Only numbers can be entered
                      onSubmitted: (value) {
                        numbersNotifier.maxDaily = double.parse(value);
                      },
                    );
                  },
                ),
              ],
            )));
  }
}
