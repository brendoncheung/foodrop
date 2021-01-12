import 'package:flutter/material.dart';

class RecurringDayList extends StatelessWidget with ChangeNotifier {
//  final Map days = Map<int, String>();
  Map days = {
    0: 'M',
    1: 'T',
    2: 'W',
    3: 'Th',
    4: 'F',
    5: 'Sa',
    6: 'Su',
  };

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: 7,
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 50, mainAxisSpacing: 5, crossAxisSpacing: 5),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              print("hello");
            },
            child: Container(
              child: Text("${days[index]}"),
              decoration: BoxDecoration(
                color: Colors.amber,
                border: Border.all(color: Colors.amber),
              ),
              height: 50,
              width: 50,
            ),
          );
        });
  }
}
