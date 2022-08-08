import 'package:daily_spending_tracker/controllers/number_controllers/numbers_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../widgets/custom_app_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(),
      body: Center(
        child: Consumer<NumbersController>(
          builder: (context, NumbersController numbersNotifier, Widget? child) {
            return Column(children: [
              Text(
                  'Daily Max: \$${numbersNotifier.maxDaily.toStringAsFixed(2)}'),
              Text(
                  "Today's Total: \$${numbersNotifier.currentTotal.toStringAsFixed(2)}"),
              Text(
                  "Last Update: ${DateTime.parse(numbersNotifier.timeStamp).year}/${DateTime.parse(numbersNotifier.timeStamp).month}/${DateTime.parse(numbersNotifier.timeStamp).day}"),
              TextButton(
                onPressed: () {
                  numbersNotifier.resetDailyLimit();
                },
                child: const Text("Reset Daily Total"),
              )
            ]);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => displayInput(),
      ),
    );
  }

  void displayInput() {
    showDialog(
      context: context,
      builder: (context) {
        return Consumer<NumbersController>(
          builder: (context, NumbersController numbersNotifier, Widget? child) {
            return AlertDialog(
              title: const Text("New Transaction"),
              content: TextField(
                decoration: const InputDecoration(labelText: "\$0.00"),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                ],
                onSubmitted: (value) {
                  numbersNotifier.currentTotal = double.parse(value);
                  Navigator.of(context).pop();
                },
              ),
            );
          },
        );
      },
    );
  }
}
