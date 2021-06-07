import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodrop/screens/common_widgets/starting_ending_time_picker.dart';

class PromoPeriodDateTimePicker extends StatefulWidget {
  const PromoPeriodDateTimePicker({Key key, @required this.daysSelected})
      : super(key: key);
  final void Function(Map<String, bool>) daysSelected;

  @override
  _PromoPeriodDateTimePickerState createState() =>
      _PromoPeriodDateTimePickerState();
}

class _PromoPeriodDateTimePickerState extends State<PromoPeriodDateTimePicker> {
  bool _mon = false;
  bool _tue = false;
  bool _wed = false;
  bool _thu = false;
  bool _fri = false;
  bool _sat = false;
  bool _sun = false;

  var _startingTime = TimeOfDay.now();
  var _endingTime = TimeOfDay.now();
  TimeOfDay pickedStartingTime;
  TimeOfDay pickedEndingTime;
  bool _isAllDay = false;
  bool _isEveryDay = false;

  _submit() {
    widget.daysSelected({
      "mon": _mon,
      "tue": _tue,
      "wed": _wed,
      "thu": _thu,
      "fri": _fri,
      "sat": _sat,
      "sun": _sun,
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select days"),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 16,
                ),
                Text(
                  "Restrict your promotion to particular day and time of the week",
                  style: TextStyle(fontSize: 24),
                ),
                _buildMondayTile(),
                _buildTuesdayTile(),
                _buildWednesdayTile(),
                _buildThursdayTile(),
                _buildFridayTile(),
                _buildSaturdayTile(),
                _buildSundayTile(),
                SizedBox(
                  height: 16,
                ),
                CheckboxListTile(
                  value: _isAllDay,
                  onChanged: (value) => _isAllDay = value,
                  title: Text("Switch to all day event"),
                  subtitle: Text("All day event runs from 0.01am to 11:59pm"),
                ),
                StartingEndingTimePicker(
                  selectedStartingTime: _startingTime,
                  onSelectedStartingTime: (time) =>
                      setState(() => _startingTime = time),
                  selectedEndingTime: _endingTime,
                  onSelectedEndingTime: (time) =>
                      setState(() => _endingTime = time),
                ),
                SizedBox(
                  height: 16,
                ),
                ElevatedButton(
                  onPressed: () => _submit(),
                  child: Text("Confirm"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<Null> _pickStartingTime(BuildContext context) async {
    pickedStartingTime = await showTimePicker(
      context: context,
      initialTime: _startingTime,
    );
    if (pickedStartingTime != null) {
      setState(() {
        _startingTime = pickedStartingTime;
      });
    }
  }

  Future<Null> _pickEndingTime(BuildContext context) async {
    pickedStartingTime = await showTimePicker(
      context: context,
      initialTime: _startingTime,
    );
    if (pickedStartingTime != null) {
      setState(() {
        _startingTime = pickedStartingTime;
      });
    }
  }

  CheckboxListTile _buildMondayTile() {
    return CheckboxListTile(
      value: _mon,
      onChanged: (value) {
        setState(() {
          _mon = value;
        });
      },
      selected: _mon,
      checkColor: Colors.amber,
      // activeColor: Colors.green,
      selectedTileColor: Colors.amber,
      controlAffinity: ListTileControlAffinity.leading,
      title: Text("Monday"),
    );
  }

  CheckboxListTile _buildTuesdayTile() {
    return CheckboxListTile(
      value: _tue,
      onChanged: (value) {
        setState(() {
          _tue = value;
        });
      },
      selected: _tue,
      checkColor: Colors.amber,
      // activeColor: Colors.green,
      selectedTileColor: Colors.amber,
      controlAffinity: ListTileControlAffinity.leading,
      title: Text("Tuesday"),
    );
  }

  CheckboxListTile _buildWednesdayTile() {
    return CheckboxListTile(
      value: _wed,
      onChanged: (value) {
        setState(() {
          _wed = value;
        });
      },
      selected: _wed,
      checkColor: Colors.amber,
      // activeColor: Colors.green,
      selectedTileColor: Colors.amber,
      controlAffinity: ListTileControlAffinity.leading,
      title: Text("Wednesday"),
    );
  }

  CheckboxListTile _buildThursdayTile() {
    return CheckboxListTile(
      value: _thu,
      onChanged: (value) {
        setState(() {
          _thu = value;
        });
      },
      selected: _thu,
      checkColor: Colors.amber,
      // activeColor: Colors.green,
      selectedTileColor: Colors.amber,
      controlAffinity: ListTileControlAffinity.leading,
      title: Text("Thursday"),
    );
  }

  CheckboxListTile _buildFridayTile() {
    return CheckboxListTile(
      value: _fri,
      onChanged: (value) {
        setState(() {
          _fri = value;
        });
      },
      selected: _fri,
      checkColor: Colors.amber,
      // activeColor: Colors.green,
      selectedTileColor: Colors.amber,
      controlAffinity: ListTileControlAffinity.leading,
      title: Text("Friday"),
    );
  }

  CheckboxListTile _buildSaturdayTile() {
    return CheckboxListTile(
      value: _sat,
      onChanged: (value) {
        setState(() {
          _sat = value;
        });
      },
      selected: _sat,
      checkColor: Colors.amber,
      // activeColor: Colors.green,
      selectedTileColor: Colors.amber,
      controlAffinity: ListTileControlAffinity.leading,
      title: Text("Saturday"),
    );
  }

  CheckboxListTile _buildSundayTile() {
    return CheckboxListTile(
      value: _sun,
      onChanged: (value) {
        setState(() {
          _sun = value;
        });
      },
      selected: _sun,
      checkColor: Colors.amber,
      // activeColor: Colors.green,
      selectedTileColor: Colors.amber,
      controlAffinity: ListTileControlAffinity.leading,
      title: Text("Sunday"),
    );
  }
}
