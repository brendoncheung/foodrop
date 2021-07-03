import 'package:flutter/material.dart';
import 'package:foodrop/core/models/UserProfile.dart';
import 'package:provider/provider.dart';

class ClientOrderScreen extends StatelessWidget {
  const ClientOrderScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Consumer<UserProfile>(
          builder: (_, user, widget) {
            print("user profle null ${user == null}");
            return Text(user.defaultBusinessId);
          },
        ),
      ),
    );
  }
}
