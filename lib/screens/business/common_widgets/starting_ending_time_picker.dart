import 'package:flutter/material.dart';

import 'input_dropdown.dart';

class StartingEndingTimePicker extends StatelessWidget {
  const StartingEndingTimePicker({
    Key key,
    this.selectedStartingTime,
    this.onSelectedStartingTime,
    this.selectedEndingTime,
    this.onSelectedEndingTime,
  }) : super(key: key);

  final TimeOfDay selectedStartingTime;
  final ValueChanged<TimeOfDay> onSelectedStartingTime;
  final TimeOfDay selectedEndingTime;
  final ValueChanged<TimeOfDay> onSelectedEndingTime;

  Future<void> _selectStartingTime(BuildContext context) async {
    final pickedTime = await showTimePicker(
        context: context, initialTime: selectedStartingTime);
    if (pickedTime != null && pickedTime != selectedStartingTime) {
      onSelectedStartingTime(pickedTime);
    }
  }

  Future<void> _selectEndingTime(BuildContext context) async {
    final pickedTime =
        await showTimePicker(context: context, initialTime: selectedEndingTime);
    if (pickedTime != null && pickedTime != selectedEndingTime) {
      onSelectedEndingTime(pickedTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    final valueStyle = Theme.of(context).textTheme.headline6;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: InputDropdown(
            labelText: "Starting Time",
            valueText: selectedStartingTime.format(context),
            valueStyle: valueStyle,
            onPressed: () => _selectStartingTime(context),
          ),
        ),
        SizedBox(width: 12.0),
        Expanded(
          flex: 5,
          child: InputDropdown(
            labelText: "Ending Time",
            valueText: selectedEndingTime.format(context),
            valueStyle: valueStyle,
            onPressed: () => _selectEndingTime(context),
          ),
        ),
      ],
    );
  }
}
