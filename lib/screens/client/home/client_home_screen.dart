import 'package:flutter/material.dart';
import 'package:foodrop/core/models/UserProfile/UserProfile.dart';
import 'package:provider/provider.dart';

import './home_tile_widget.dart';

class ClientHomeScreen extends StatefulWidget {
  const ClientHomeScreen({Key key}) : super(key: key);

  @override
  _ClientHomeScreenState createState() => _ClientHomeScreenState();
}

class _ClientHomeScreenState extends State<ClientHomeScreen> {
  @override
  Widget build(BuildContext context) {
    // var client_auth = Provider.of<AuthenticationService>(context);
    // final userClient = Provider.of<UserProfile>(context);
    // final auth = Provider.of<AuthenticationService>(context);
    // final db = Provider.of<Database>(context);
    //
    // final user = auth.getUser();

    final source = "https://source.unsplash.com/random/1600x900";
    // new AssetImage("assets/images/keyboard.jpg")
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
      ),
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey[800],
        title: Text("Home"),
        // actions: [IconButton(icon: Icon(Icons.logout), onPressed: () => client_auth.logOutUser())],
        actions: [
          Padding(
            padding: EdgeInsets.all(20.0),
            child: GestureDetector(
              child: Icon(Icons.search),
            ),
          )
        ],
      ),
      body: Container(
        color: Colors.grey[800],
        child: GridView.builder(
          padding: EdgeInsets.all(7),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 7.0,
            mainAxisSpacing: 7.0,
          ),
          itemBuilder: (context, index) {
            return HomeTileWidget(mainSrc: source);
          },
          itemCount: 10,
        ),
      ),
    );
  }

  _printUser(BuildContext context) {
    final user = Provider.of<UserProfile>(context, listen: false);
    print(user.uid);
    print(user.emailAddress);
    print(user.mobileNumber);
    print(user.isAnonymous);
    print(user.signedInViaEmail);
  }
}
