import 'package:flutter/material.dart';

class UnknownRouteScreen extends StatelessWidget {
  final String routeInfo;

  UnknownRouteScreen({this.routeInfo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Error!")),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("You are seeing this page because this route has not yet been registered/ implemented, called on onUnknownRoute in MaterialApp"),
              SizedBox(height: 16),
              Text("Route name: $routeInfo"),
            ],
          ),
        ));
  }
}
