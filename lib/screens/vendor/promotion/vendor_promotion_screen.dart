import 'package:flutter/material.dart';
import 'promotion_all.dart';
import 'promotion_current.dart';
import 'promotion_coming.dart';
import 'promotion_expired.dart';
import 'vendor_add_new_promo.dart';

class VendorPromotionScreen extends StatefulWidget {
  const VendorPromotionScreen({Key key}) : super(key: key);

  @override
  _VendorPromotionScreenState createState() => _VendorPromotionScreenState();
}

class _VendorPromotionScreenState extends State<VendorPromotionScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  ScrollController _scrollController;

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (ctx) => VendorAddNewPromo()));
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.black54.withOpacity(0.5),
      ),
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (BuildContext context, bool boxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              centerTitle: true,
              title: Text(
                "Promotions",
                style: TextStyle(fontSize: 30),
              ),
              bottom: buildTabBar(), // <----- BuildTabBar
              expandedHeight: 120,
//              forceElevated: true,
              floating: true,
              pinned: true,
              flexibleSpace: Stack(
                children: [
                  Positioned.fill(
                      child: Image.asset(
                    'assets/images/restaurants/restaurant2.jpg',
                    // TODO: load restaurant images dynamically
                    fit: BoxFit.cover,
                  )),
                  Container(
                    color: Colors.black54.withOpacity(0.3),
                  )
                ],
              ),
            ),
          ];
        },
        body: TabBarView(
          children: [
            PromotionAll(),
            PromotionCurrent(),
            PromotionComing(),
            PromotionExpired(),
          ],
          controller: _tabController,
        ),
      ),
    );
  }

  TabBar buildTabBar() {
    return TabBar(
      controller: _tabController,
      labelColor: Colors.redAccent,
      unselectedLabelColor: Colors.white,
      indicatorSize: TabBarIndicatorSize.label,
      indicator: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
          color: Colors.white),
      tabs: [
        Tab(
          child: Align(
            alignment: Alignment.center,
            child: Text(
              "All",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Tab(
          child: Align(
            alignment: Alignment.center,
            child: Text(
              "Current",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Tab(
          child: Align(
            alignment: Alignment.center,
            child: Text(
              "Coming",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Tab(
          child: Align(
            alignment: Alignment.center,
            child: Text(
              "Expired",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}
