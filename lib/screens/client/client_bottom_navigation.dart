import 'package:flutter/material.dart';
import 'package:foodrop/core/authentication/authentication_service.dart';
import 'package:foodrop/core/models/UserProfile.dart';
import 'package:foodrop/core/services/database.dart';
import 'package:foodrop/screens/authentication/profile_landing_screen.dart';
import 'package:foodrop/screens/business/business_home_screen.dart';
import 'package:foodrop/screens/business/menu_screen.dart';
import 'package:foodrop/screens/business/promo/promo_page.dart';
import 'package:foodrop/screens/business/promotion_screen.dart';
import 'package:foodrop/screens/business/reward_screen.dart';
import 'package:foodrop/screens/client/favourite/client_favourite_screen.dart';
import 'package:foodrop/screens/client/gift/client_gift_screen.dart';
import 'package:foodrop/screens/client/home/client_home_screen.dart';
import 'package:foodrop/screens/client/orders/client_order_screen.dart';
import 'package:provider/provider.dart';

class ClientBottomNavigation extends StatefulWidget {
  // void Function(int) onTap;
  // ClientBottomNavigation({this.onTap});
  ClientBottomNavigation({this.userProfile});
  UserProfile userProfile;

  static Widget create(BuildContext context, Database _db) {
    Widget _circularProgressIndicatorInCenter() {
      return Scaffold(
        backgroundColor: Colors.grey[800],
        body: Center(
            child: Container(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text("Loading"),
            SizedBox(
              height: 10,
            ),
            CircularProgressIndicator()
          ]),
        )),
      );
    }

    final _auth = Provider.of<AuthenticationService>(context, listen: false);
    final _user = _auth.getUser();
    final String uid = _user.uid;
    // final _db = Provider.of<Database>(context);
    return StreamBuilder<UserProfile>(
        stream: _db.userClientStream(uid),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              {
                return _circularProgressIndicatorInCenter();
              }
              break;
            case ConnectionState.active:
              {
                return ChangeNotifierProvider<UserProfile>(
                    create: (context) => snapshot.data,
                    child: ClientBottomNavigation(userProfile: snapshot.data));
              }
              break;
            default:
              {
                return _circularProgressIndicatorInCenter();
              }
              break;
          }
        });
  }

  @override
  _ClientBottomNavigationState createState() => _ClientBottomNavigationState();
}

class _ClientBottomNavigationState extends State<ClientBottomNavigation> {
  var _selectedIndex = 0;
  final _clientBottomNavigationScreens = [
    ClientHomeScreen(),
    ClientFavouriteScreen(),
    ClientGiftScreen(),
    ClientOrderScreen(),
    ProfileLandingScreen()
  ];
  final _businessBottomNavigationScreens = [
    BusinessHomeScreen(),
    MenuScreen(),
    PromoPage(),
    RewardScreen(),
    ProfileLandingScreen()
  ];

  void onTapHandler(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // _selectedIndex = 0;
    print("rebuild client bottom navigation!!");
    final _userProfile = Provider.of<UserProfile>(context);

    return _userProfile == null
        ? Scaffold(
            body: _clientBottomNavigationScreens[_selectedIndex],
            bottomNavigationBar: _buildUserBottomNavigationBar(),
          )
        : Scaffold(
            body: _userProfile.defaultVendorMode
                ? _businessBottomNavigationScreens[_selectedIndex]
                : _clientBottomNavigationScreens[_selectedIndex],
            bottomNavigationBar: _userProfile.defaultVendorMode
                ? _buildBusinessUserBottomNavigationBar()
                : _buildUserBottomNavigationBar(),
          );
  }

  BottomNavigationBar _buildUserBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      onTap: onTapHandler,
      currentIndex: _selectedIndex,
      backgroundColor: Colors.grey[900],
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.grey[500],
      items: [
        BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded, size: 35), label: ""),
        BottomNavigationBarItem(icon: Icon(Icons.search, size: 35), label: ""),
        BottomNavigationBarItem(
            icon: Icon(Icons.comment_rounded, size: 35), label: ""),
        BottomNavigationBarItem(
            icon: Icon(Icons.person_rounded, size: 35), label: ""),
        BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: ""),
      ],
    );
  }

  BottomNavigationBar _buildBusinessUserBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      onTap: onTapHandler,
      currentIndex: _selectedIndex,
      backgroundColor: Colors.grey[900],
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.grey[500],
      items: [
        BottomNavigationBarItem(
            icon: Icon(Icons.business_rounded, size: 35), label: ""),
        BottomNavigationBarItem(
            icon: Icon(Icons.menu_book_rounded, size: 35), label: ""),
        BottomNavigationBarItem(
            icon: Icon(Icons.event_rounded, size: 35), label: ""),
        BottomNavigationBarItem(
            icon: Icon(Icons.card_giftcard_rounded, size: 35), label: ""),
        BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: ""),
      ],
    );
  }
}
