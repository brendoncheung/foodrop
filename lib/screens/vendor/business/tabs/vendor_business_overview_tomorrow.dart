import 'package:flutter/material.dart';
import 'package:foodrop/screens/vendor/widgets/business_glance_tile.dart';

class VendorBusinessOverviewTomorrowScreen extends StatefulWidget {
  @override
  _VendorBusinessOverviewTomorrowScreenState createState() => _VendorBusinessOverviewTomorrowScreenState();
}

class _VendorBusinessOverviewTomorrowScreenState extends State<VendorBusinessOverviewTomorrowScreen> with SingleTickerProviderStateMixin {
  final List<Tab> tabs = [Tab(text: "Today"), Tab(text: "Tommorrow")];

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: tabs.length);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BusinessGlanceTile(title: "Total customer visits", number: 11),
        BusinessGlanceTile(title: "Distinct customer visits", number: 11),
        BusinessGlanceTile(title: "Repeat customer visit", number: 11),
        BusinessGlanceTile(title: "New customers", number: 11),
        Divider(height: 1),
        BusinessGlanceTile(title: "Customer visits", number: 11),
        BusinessGlanceTile(title: "Customer visits", number: 11),
        BusinessGlanceTile(title: "Customer visits", number: 11),
      ],
    );
  }
}
