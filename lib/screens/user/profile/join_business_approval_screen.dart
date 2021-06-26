import 'package:flutter/material.dart';
import 'package:foodrop/core/models/business.dart';

class JoinBusinessApprovalScreen extends StatefulWidget {
  JoinBusinessApprovalScreen({this.business});
  Business business;

  @override
  _JoinBusinessApprovalScreenState createState() =>
      _JoinBusinessApprovalScreenState();
}

class _JoinBusinessApprovalScreenState
    extends State<JoinBusinessApprovalScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Approval"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              maxLines: 10,
            )
          ],
        ),
      ),
    );
  }
}
