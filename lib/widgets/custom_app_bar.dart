import 'package:daily_spending_tracker/controllers/theme_controller/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

PreferredSizeWidget customAppBar() {
  return AppBar(
    // Provide a standard title.
    title: const Text("Daily Savings Tracker"),
    centerTitle: true,
    // Allows the user to reveal the app bar if they begin floatingActionButtonOpacity
    // back up the list of items.
    elevation: 10,
    actions: [
      Consumer<ThemeController>(
          builder: (context, ThemeController themeNotifier, child) {
        return IconButton(
            icon: Icon(
                themeNotifier.isDark ? Icons.nightlight_round : Icons.wb_sunny),
            onPressed: () {
              themeNotifier.isDark
                  ? themeNotifier.isDark = false
                  : themeNotifier.isDark = true;
            });
      }),
    ],
  );
}
