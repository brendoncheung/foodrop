import 'package:flutter/material.dart';
import 'package:foodrop/screens/vendor/business/tabs/vendor_business_overview_today.dart';
import 'package:foodrop/screens/vendor/business/tabs/vendor_business_overview_yesterday.dart';

class VendorBusinessTabScreen extends StatefulWidget {
  VendorBusinessTabScreen({Key key}) : super(key: key);

  @override
  _VendorBusinessTabScreenState createState() => _VendorBusinessTabScreenState();
}

class _VendorBusinessTabScreenState extends State<VendorBusinessTabScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: TabBarView(
          children: [VendorBusinessOverviewTodayScreen(), VendorBusinessOverviewTomorrowScreen()],
        ),
        appBar: AppBar(
          title: Text("Business overview"),
          bottom: TabBar(
            tabs: [
              Tab(text: "Today", icon: Icon(Icons.today)),
              Tab(text: "Yesterday", icon: Icon(Icons.calendar_view_day)),
            ],
          ),
        ),
      ),
    );
  }
}
