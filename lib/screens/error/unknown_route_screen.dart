import 'package:flutter/material.dart';

class UnknownRouteScreen extends StatelessWidget {
  final String routeInfo;

  UnknownRouteScreen({this.routeInfo});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Text("Sorry, unknown route: $routeInfo"),
      ),
    );
  }
}
