import 'package:daily_spending_tracker/controllers/number_controllers/numbers_controller.dart';
import 'package:daily_spending_tracker/controllers/payroll_controller/payroll_controller.dart';
import 'package:daily_spending_tracker/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
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
          child: ListView(children: [
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
                    child: Consumer<NumbersController>(
                      builder: (context, NumbersController numbersNotifier,
                          Widget? child) {
                        return Column(
                          children: [
                            const Center(
                              child: Text("Daily Max:",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 30)),
                            ),
                            Text(
                                "\$${numbersNotifier.maxDaily.toStringAsFixed(2)}",
                                style: const TextStyle(fontSize: 30)),
                            TextButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                          title:
                                              const Text("New Daily Maximum"),
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
                                            inputFormatters: <
                                                TextInputFormatter>[
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
                          ],
                        );
                      },
                    ),
                  ),
                )),
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
                      child: Consumer<NumbersController>(builder: (context,
                          NumbersController numbersNotifier, Widget? child) {
                        return Column(
                          children: [
                            const Center(
                              child: Text("Rolling Daily Budget:",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 30)),
                            ),
                            Text(
                                "\$${numbersNotifier.rollingTotal.toStringAsFixed(2)}",
                                style: const TextStyle(fontSize: 30)),
                            TextButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                          title:
                                              const Text("Reset Rolling Total"),
                                          content: Text(
                                              "Reset rolling total to \$${numbersNotifier.maxDaily}?"),
                                          actionsAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  numbersNotifier
                                                      .resetRollingDailyLimit();
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
                              child: const Text("Reset Rolling Total"),
                            ),
                          ],
                        );
                      }),
                    )),
              ),
            )),
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
                      child: Consumer<NumbersController>(builder: (context,
                          NumbersController numbersNotifier, Widget? child) {
                        return Column(
                          children: [
                            const Center(
                              child: Text("Spent Today:",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 30)),
                            ),
                            Text(
                                "\$${(numbersNotifier.maxDaily - numbersNotifier.dailyTotal).toStringAsFixed(2)}",
                                style: const TextStyle(fontSize: 30)),
                            TextButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                          title:
                                              const Text("Reset Today's Total"),
                                          content: Text(
                                              "Reset daily total to \$${numbersNotifier.maxDaily}?"),
                                          actionsAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  numbersNotifier
                                                      .resetDailyLimit();
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
                              child: const Text("Reset Today's Total"),
                            ),
                          ],
                        );
                      })),
                )),
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
                      child: Consumer<FrequencyController>(builder: (context,
                          FrequencyController frequencyNotifier,
                          Widget? child) {
                        return Column(children: [
                          const Center(
                            child: Text("Average to Maintain:",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 30)),
                          ),
                          Consumer<NumbersController>(builder: (context,
                              NumbersController numbersNotifier,
                              Widget? child) {
                            return Text(
                                //rolling budget
                                //!! figure out best way to find average left based on next payment date.
                                (((compareTimeStamps(frequencyNotifier.payDate,
                                                    DateTime.now()) *
                                                numbersNotifier.maxDaily) +
                                            numbersNotifier.rollingTotal) /
                                        compareTimeStamps(
                                            frequencyNotifier.payDate,
                                            DateTime.now()))
                                    .toStringAsFixed(2),
                                style: const TextStyle(fontSize: 30));
                          }),
                          const Text("Next Payment Date:",
                              style: TextStyle(fontSize: 20)),
                          Text(
                              DateFormat("MMMM dd yyyy")
                                  .format(frequencyNotifier.payDate),
                              style: const TextStyle(fontSize: 15)),
                          TextButton(
                            onPressed: () async {
                              await showDatePicker(
                                context: context,
                                initialDate: frequencyNotifier.payDate,
                                firstDate: DateTime.now(),
                                lastDate: frequencyNotifier.payDate
                                    .add(const Duration(days: 600)),
                              ).then((selectedDate) {
                                if (selectedDate != null) {
                                  setState(() {
                                    frequencyNotifier.payDate = selectedDate;
                                  });
                                }
                              });
                            },
                            child: const Text("Date not correct?"),
                          )
                        ]);
                      })),
                )),
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
                      child: Consumer<FrequencyController>(builder: (context,
                          FrequencyController frequencyNotifier,
                          Widget? child) {
                        return Column(children: [
                          const Center(
                            child: Text("Pay Schedule:",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 30)),
                          ),
                          Text(frequencyNotifier.frequency,
                              style: const TextStyle(fontSize: 30)),
                          TextButton(
                              onPressed: (() {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return SimpleDialog(
                                      title: const Text("Payment Frequency"),
                                      children: frequencyNotifier.options
                                          .map((String option) {
                                        return SimpleDialogOption(
                                          onPressed: () {
                                            frequencyNotifier.frequency =
                                                option;
                                            Navigator.of(context).pop();
                                          },
                                          child: Text(option,
                                              style: frequencyNotifier
                                                          .frequency ==
                                                      option
                                                  ? const TextStyle(
                                                      fontStyle:
                                                          FontStyle.italic,
                                                      fontWeight:
                                                          FontWeight.bold)
                                                  : null),
                                        );
                                      }).toList(),
                                    );
                                  },
                                );
                              }),
                              child: const Text("Change Payment Schedule"))
                        ]);
                      })),
                )),
          ),
        ),
      ])),
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
                        numbersNotifier.rollingTotal = double.parse(value);
                        numbersNotifier.dailyTotal = double.parse(value);
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

  Future<DateTime> _selectDate(
      BuildContext context, DateTime initialDate) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != initialDate) {
      return picked;
    } else {
      return initialDate;
    }
  }
}
