import 'package:daily_spending_tracker/controllers/number_controllers/numbers_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
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
            return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: SizedBox(
                      width: double.infinity,
                      child: Card(
                          elevation: 5,
                          color: Theme.of(context).colorScheme.surfaceVariant,
                          child: Align(
                              alignment: Alignment.center,
                              child: Padding(
                                padding: const EdgeInsets.all(30),
                                child: Column(
                                  children: [
                                    const Text("Daily Budget:",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 40)),
                                    Text(
                                        "\$${numbersNotifier.maxDaily.toStringAsFixed(2)}",
                                        style: const TextStyle(fontSize: 40))
                                  ],
                                ),
                              ))),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: SizedBox(
                      width: double.infinity,
                      child: Card(
                          elevation: 5,
                          color: Theme.of(context).colorScheme.surfaceVariant,
                          child: Align(
                            alignment: Alignment.center,
                            child: Padding(
                                padding: const EdgeInsets.all(30),
                                child: Column(
                                  children: [
                                    const Text("Today's Budget:",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 40)),
                                    Text(
                                        "\$${numbersNotifier.currentTotal.toStringAsFixed(2)}",
                                        style: const TextStyle(fontSize: 40))
                                  ],
                                )),
                          )),
                    ),
                  ),
                ]);
          },
        ),
      ),
      persistentFooterButtons: [
        Consumer<NumbersController>(
          builder: (context, NumbersController numbersNotifier, Widget? child) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                              title: const Text("New Daily Maximum"),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text("Cancel")),
                              ],
                              content: TextField(
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: "Maximum",
                                  prefixText: "\$ ",
                                ),
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'^\d+\.?\d{0,2}')),
                                ], // Only numbers can be entered
                                onSubmitted: (value) {
                                  numbersNotifier.maxDaily =
                                      double.parse(value);
                                  Navigator.of(context).pop();
                                },
                              ));
                        },
                      );
                    },
                    child: const Text("Set New Max")),
                TextButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                              title: const Text("Reset Daily Total"),
                              content: Text(
                                  "Reset daily total to \$${numbersNotifier.maxDaily}?"),
                              actionsAlignment: MainAxisAlignment.spaceEvenly,
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      numbersNotifier.resetDailyLimit();
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text("Yes")),
                                TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                    child: const Text("No"))
                              ]);
                        });
                  },
                  child: const Text("Reset Daily Total"),
                ),
              ],
            );
          },
        ),
      ],
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.attach_money),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return Consumer<NumbersController>(
                builder: (context, NumbersController numbersNotifier,
                    Widget? child) {
                  return AlertDialog(
                    title: const Text("New Transaction"),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text("Cancel")),
                    ],
                    content: TextField(
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Money Spent",
                          prefixText: "\$ "),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^\d+\.?\d{0,2}')),
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
        },
      ),
    );
  }
}
