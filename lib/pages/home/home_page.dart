import 'package:daily_spending_tracker/controllers/number_controllers/numbers_controller.dart';
import 'package:flutter/material.dart';
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
              Text('Daily Max: ${numbersNotifier.maxDaily}'),
              Text('Current Total: ${numbersNotifier.currentTotal}')
            ]);
          },
        ),
      ),
    );
  }
}
