import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:foodrop/core/authentication/authentication_service.dart';
import 'package:foodrop/core/models/UserProfile/UserProfile.dart';
import 'package:foodrop/core/services/database.dart';
import 'package:foodrop/screens/client/profile/client_profile_screen.dart';
import 'package:provider/provider.dart';

import '../../authentication/sign_in_page.dart';
import './home_tile_widget.dart';

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
    final db = Provider.of<Database>(context);

    final user = auth.getUser();
    bool isUserSignedIn = false;

    try {
      if (user.email != null) {
        print("use is =======> ${user.email}");
        isUserSignedIn = true;
      }
    } catch (e) {
      print("user is not signed in xxxxxxxxxx");
    }

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
                    child: isUserSignedIn
                        ? ClientProfileScreen()
                        : SignInPage(), // Database dependency injection
                  ), // if user logged in then display a different page
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
