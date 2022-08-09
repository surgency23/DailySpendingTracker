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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: SizedBox(
                          width: double.infinity,
                          child: Card(
                              elevation: 5,
                              color:
                                  Theme.of(context).colorScheme.surfaceVariant,
                              child: Align(
                                  alignment: Alignment.center,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      children: [
                                        const Text("Daily Budget:",
                                            style: TextStyle(
                                                //color: Colors.grey[800],
                                                fontWeight: FontWeight.w500,
                                                //fontStyle: FontStyle.italic,
                                                //fontFamily: 'Open Sans',
                                                fontSize: 40)),
                                        Text(
                                            "\$${numbersNotifier.maxDaily.toStringAsFixed(2)}",
                                            style: const TextStyle(
                                                //color: Colors.grey[800],
                                                //fontWeight: FontWeight.w500,
                                                //fontStyle: FontStyle.italic,
                                                //fontFamily: 'Open Sans',
                                                fontSize: 40))
                                      ],
                                    ),
                                  ))),
                        ),
                      ), //Text('Daily Max: \$${numbersNotifier.maxDaily.toStringAsFixed(2)}')
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: SizedBox(
                          width: double.infinity,
                          child: Card(
                              elevation: 5,
                              color:
                                  Theme.of(context).colorScheme.surfaceVariant,
                              child: Align(
                                alignment: Alignment.center,
                                child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      children: [
                                        const Text("Today's Budget:",
                                            style: TextStyle(
                                                //color: Colors.grey[800],
                                                fontWeight: FontWeight.w500,
                                                //fontStyle: FontStyle.italic,
                                                //fontFamily: 'Open Sans',
                                                fontSize: 40)),
                                        Text(
                                            "\$${numbersNotifier.currentTotal.toStringAsFixed(2)}",
                                            style: const TextStyle(
                                                //color: Colors.grey[800],
                                                //fontWeight: FontWeight.w500,
                                                //fontStyle: FontStyle.italic,
                                                //fontFamily: 'Open Sans',
                                                fontSize: 40))
                                      ],
                                    )),
                              )),
                        ),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      numbersNotifier.resetDailyLimit();
                    },
                    child: const Text("Reset Daily Total"),
                  ),

                  // \$${numbersNotifier.currentTotal.toStringAsFixed(2)}
                ]);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.attach_money),
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
