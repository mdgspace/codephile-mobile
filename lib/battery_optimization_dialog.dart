import 'package:battery_optimization/battery_optimization.dart';
import 'package:codephile/resources/colors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BatteryOptimisationDialog extends StatefulWidget {
  const BatteryOptimisationDialog({Key? key}) : super(key: key);

  @override
  _BatteryOptimisationDialogState createState() =>
      _BatteryOptimisationDialogState();
}

class _BatteryOptimisationDialogState extends State<BatteryOptimisationDialog> {
  bool _showBatteryOptimizationDialog = true;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Icon(
        Icons.notifications_active,
        color: codephileMain,
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          const Text(
            "Please disable battery optimisation for Codephile to receive notifications on time",
            style: TextStyle(
              color: primaryBlackText,
              fontSize: 16.0,
            ),
          ),
          Row(
            children: <Widget>[
              Checkbox(
                value: !_showBatteryOptimizationDialog,
                activeColor: codephileMain,
                onChanged: (value) {
                  setState(() {
                    _showBatteryOptimizationDialog = !value!;
                  });
                },
              ),
              const Text(
                "Do not show again",
                style: TextStyle(
                  color: secondaryTextGrey,
                ),
              )
            ],
          )
        ],
      ),
      actions: <Widget>[
        TextButton(
          child: const Text(
            "Cancel",
            style: TextStyle(color: codephileMain),
          ),
          onPressed: () {
            setBoolValue();
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text(
            "Open Settings",
            style: TextStyle(color: codephileMain),
          ),
          onPressed: () {
            setBoolValue();
            BatteryOptimization.openBatteryOptimizationSettings().then(
              (value) => Navigator.of(context).pop(),
            );
          },
        ),
      ],
    );
  }

  void setBoolValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(
      "showBatteryOptimisationDialog",
      _showBatteryOptimizationDialog,
    );
  }
}
