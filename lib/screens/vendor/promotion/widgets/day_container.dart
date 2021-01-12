import 'package:flutter/material.dart';

class DayContainer extends StatelessWidget {
  final double size;
  DayContainer(this.size);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      height: size,
      width: size,
      color: Colors.amber,
    );
  }
}
