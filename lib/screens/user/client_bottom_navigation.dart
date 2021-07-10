import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../core/authentication/authentication_service.dart';
import '../../core/models/UserProfile.dart';

import '../../core/models/business.dart';
import '../../core/services/custom_colors.dart';
import '../../core/services/repositories/qr_transaction_repository.dart';
import '../authentication/profile_landing_screen.dart';
import '../business/business_home/business_home_screen_v1.dart';

import '../business/menu/menu_screen.dart';
import '../business/promotion_screen.dart';

import '../business/qr_code_main_screen/qr_code_history.dart';

import '../business/reward_screen.dart';
import '../../core/services/database/database.dart';

import 'qr_code_scan/qr_code_scan_screen.dart';

import 'gift/client_gift_screen.dart';
import 'home/client_home_screen.dart';
import 'orders/client_order_screen.dart';
import 'package:provider/provider.dart';

class ClientBottomNavigation extends StatefulWidget {
  ClientBottomNavigation({this.userProfile});
  final UserProfile userProfile;

  static Widget create(BuildContext context, Database _db) {
    Widget _circularProgressIndicatorInCenter() {
      return Scaffold(
        backgroundColor: Colors.grey[900],
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
              return MultiProvider(
                providers: [
                  ProxyProvider<FirebaseFirestore, QRTransactionRepository>(
                    create: (context) => QRTransactionRepository(store: Provider.of<FirebaseFirestore>(context, listen: false)),
                    update: (_, store, repo) => QRTransactionRepository(store: store),
                  ),
                  ChangeNotifierProvider<UserProfile>(create: (context) {
                    return snapshot.data;
                  }),
                ],
                child: ClientBottomNavigation(userProfile: snapshot.data),
              );
            }
            break;
          default:
            {
              return _circularProgressIndicatorInCenter();
            }
            break;
        }
      },
    );
  }

  @override
  _ClientBottomNavigationState createState() => _ClientBottomNavigationState();
}

class _ClientBottomNavigationState extends State<ClientBottomNavigation> {
  var _selectedBusinessIndex = 0;
  var _selectedUserIndex = 0;

  final _clientBottomNavigationScreens = [
    ClientHomeScreen(),
    ClientGiftScreen(),
    QRCodeScanScreen(),
    ClientOrderScreen(),
    ProfileLandingScreen(),
  ];
  final _businessBottomNavigationScreens = [
    QRCodeHistory(),
    BusinessHomeScreenV1(),
    MenuScreen(),
    PromotionScreen(),
    RewardScreen(),
    ProfileLandingScreen(),
  ];

  void onBusinessNavTapped(int index) {
    setState(() {
      _selectedBusinessIndex = index;
    });
  }

  void onUserNavTapped(int index) {
    setState(() {
      _selectedUserIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _userProfile = Provider.of<UserProfile>(context);

    return _userProfile == null
        ? Scaffold(
            body: _clientBottomNavigationScreens[_selectedUserIndex],
            bottomNavigationBar: _buildUserBottomNavigationBar(),
          )
        : Scaffold(
            body: _userProfile.defaultVendorMode ? buildBusinessNavigation(_userProfile) : _clientBottomNavigationScreens[_selectedUserIndex],
            bottomNavigationBar: _userProfile.defaultVendorMode ? _buildBusinessBottomNav() : _buildUserBottomNavigationBar(),
          );
  }

  BottomNavigationBar _buildUserBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      onTap: onUserNavTapped,
      currentIndex: _selectedUserIndex,
      backgroundColor: Colors.grey[900],
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.grey[500],
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home_rounded, size: 35), label: ""),
        BottomNavigationBarItem(icon: Icon(Icons.wallet_giftcard_rounded, size: 35), label: ""),
        BottomNavigationBarItem(icon: Icon(Icons.qr_code_scanner_rounded, size: 35), label: ""),
        BottomNavigationBarItem(icon: Icon(Icons.person_rounded, size: 35), label: ""),
        BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: ""),
      ],
    );
  }

  BottomNavigationBar _buildBusinessBottomNav() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      onTap: onBusinessNavTapped,
      currentIndex: _selectedBusinessIndex,
      backgroundColor: CustomColors.vendorAppBarColor,
      selectedItemColor: Colors.white,
      unselectedItemColor: CustomColors.vendorAppBarUnselectColor,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.qr_code), label: ""),
        BottomNavigationBarItem(icon: Icon(Icons.business_rounded, size: 35), label: ""),
        BottomNavigationBarItem(icon: Icon(Icons.menu_book_rounded, size: 35), label: ""),
        BottomNavigationBarItem(icon: Icon(Icons.event_rounded, size: 35), label: ""),
        BottomNavigationBarItem(icon: Icon(Icons.card_giftcard_rounded, size: 35), label: ""),
        BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: ""),
      ],
    );
  }

  buildBusinessNavigation(UserProfile _userProfile) {
    final _db = Provider.of<Database>(context, listen: false);

    return StreamProvider<Business>.value(
        value: _db.businessStream(businessUid: _userProfile.defaultBusinessId),
        initialData: Business(uid: _userProfile.defaultBusinessId),
        builder: (context, snapshot) {
          // print(snapshot);
          return Provider<Database>(
            create: (context) => FirestoreDatabase(uid: _userProfile.uid),
            child: Consumer<Business>(
              builder: (_, business, __) => _businessBottomNavigationScreens[_selectedBusinessIndex],
            ),
          );
        });
  }
}
