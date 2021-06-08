import 'package:flutter/material.dart';
import 'package:foodrop/core/models/UserProfile.dart';
import 'package:foodrop/core/models/business.dart';
import 'package:foodrop/core/services/database.dart';
import 'package:provider/provider.dart';

class BusinessHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _db = Provider.of<Database>(context);
    final _userProfile = Provider.of<UserProfile>(context);
    print(_userProfile.defaultBusinessId);

    return StreamBuilder<Business>(
        initialData: Business(),
        stream: _db.businessStream(businessUid: _userProfile.defaultBusinessId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              return Scaffold(
                appBar: AppBar(
                  title: Text(snapshot.data.tradingName),
                ),
              );
            }
          }
          return Scaffold(
            appBar: AppBar(
              title: Text("Problem loading data"),
            ),
            body: Center(
              child: Text(
                "You have lost access to the business.\nPlease select another store.",
                style: TextStyle(fontSize: 16),
              ),
            ),
          );
        });
  }
}
