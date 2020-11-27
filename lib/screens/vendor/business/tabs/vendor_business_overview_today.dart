import 'package:flutter/material.dart';
import 'package:foodrop/screens/vendor/business/widgets/business_glance_tile.dart';

class VendorBusinessOverviewTodayScreen extends StatefulWidget {
  @override
  _VendorBusinessOverviewTodayScreenState createState() => _VendorBusinessOverviewTodayScreenState();
}

class _VendorBusinessOverviewTodayScreenState extends State<VendorBusinessOverviewTodayScreen> with SingleTickerProviderStateMixin {
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
        BusinessGlanceTile(title: "Total customer visits", number: 56),
        BusinessGlanceTile(title: "Distinct customer visits", number: 56),
        BusinessGlanceTile(title: "Repeat customer visit", number: 56),
        BusinessGlanceTile(title: "New customers", number: 56),
      ],
    );
  }
}
