import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:foodrop/core/authentication/authentication_service.dart';
import 'package:foodrop/core/models/client/client_user.dart';
import 'package:foodrop/core/services/database.dart';
import 'package:foodrop/screens/client/home/home_tile_widget.dart';
import 'package:provider/provider.dart';

import '../../authentication/sign_in_page.dart';

class ClientHomeScreen extends StatefulWidget {
  const ClientHomeScreen({Key key}) : super(key: key);

  @override
  _ClientHomeScreenState createState() => _ClientHomeScreenState();
}

class _ClientHomeScreenState extends State<ClientHomeScreen> {
  var isUserClient = false;

  @override
  Widget build(BuildContext context) {
    // var client_auth = Provider.of<AuthenticationService>(context);
    final userClient = Provider.of<UserClient>(context);
    final auth = Provider.of<AuthenticationService>(context);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Home"),
        // actions: [IconButton(icon: Icon(Icons.logout), onPressed: () => client_auth.logOutUser())],
        actions: [
          CircleAvatar(
            child: IconButton(
              icon: Icon(Icons.person),
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => Provider<Database>(
                      create: (_) => FirestoreDatabase(uid: userClient.uid),
                      child: SignInPage()),
                  fullscreenDialog: true,
                ),
              ),
            ),
            backgroundColor: Theme.of(context).primaryColor,
          )
        ],
      ),
      body: Center(
        child: StaggeredGridView.countBuilder(
          crossAxisCount: 2,
          itemCount: 10,
          itemBuilder: (context, index) {
            return HomeTileWidget(null, "Hello", "descroption");
          },
          staggeredTileBuilder: (int index) => StaggeredTile.fit(2),
        ),
      ),
    );
  }
}
