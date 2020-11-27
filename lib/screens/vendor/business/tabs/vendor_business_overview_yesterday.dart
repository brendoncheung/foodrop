import 'package:flutter/material.dart';
import 'package:foodrop/screens/vendor/business/widgets/business_glance_tile.dart';

class VendorBusinessOverviewTomorrowScreen extends StatefulWidget {
  @override
  _VendorBusinessOverviewYesterdayScreenState createState() => _VendorBusinessOverviewYesterdayScreenState();
}

class _VendorBusinessOverviewYesterdayScreenState extends State<VendorBusinessOverviewTomorrowScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BusinessGlanceTile(title: "Total customer visits", number: 11),
        BusinessGlanceTile(title: "Distinct customer visits", number: 11),
        BusinessGlanceTile(title: "Repeat customer visit", number: 11),
        BusinessGlanceTile(title: "New customers", number: 11),
      ],
    );
  }
}
