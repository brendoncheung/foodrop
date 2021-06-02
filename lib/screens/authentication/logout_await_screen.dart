import 'package:flutter/material.dart';

class LogoutAwaitScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            Text("Logging out, please wait"),
          ],
        ),
      ),
    );
  }
}
