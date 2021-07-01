import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:foodrop/core/models/UserProfile.dart';
import 'package:foodrop/core/models/item.dart';
import 'package:foodrop/core/services/repositories/image_repository.dart';
import 'package:foodrop/core/services/repositories/item_repository.dart';
import 'package:foodrop/screens/user/home/detail/detail_item_screen.dart';
import 'package:provider/provider.dart';
import 'widgets/item_widget.dart';

class ClientHomeScreen extends StatefulWidget {
  const ClientHomeScreen({Key key}) : super(key: key);

  @override
  _ClientHomeScreenState createState() => _ClientHomeScreenState();
}

class _ClientHomeScreenState extends State<ClientHomeScreen> with SingleTickerProviderStateMixin {
  final _scrollController = ScrollController();

  final itemRepository = ItemRepository(FirebaseFirestore.instance);
  final imageRepository = ImageRepository(storage: FirebaseStorage.instance);

  void onFabTapped() {
    print("fab pressed");
  }

  void onItemTapped(Item item) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => DetailItemScreen(
          item: item,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProfile>(context);
    final PageController pageController = PageController(initialPage: 1);

    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: onFabTapped,
          child: Icon(Icons.add, color: Colors.black),
          backgroundColor: Colors.white,
        ),
        backgroundColor: Colors.black,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.grey[900],
          leading: Icon(Icons.person),
          title: TopNavigationBar(),
          actions: [
            Padding(
              padding: EdgeInsets.all(20.0),
              child: GestureDetector(
                child: Icon(Icons.search),
              ),
            )
          ],
        ),
        body: PageView(
          controller: pageController,
          physics: ClampingScrollPhysics(),
          scrollBehavior: ScrollBehavior(),
          children: [
            FollowScreen(items: itemRepository.items, onTap: onItemTapped, isUserLoggedIn: user != null),
            MarketplaceScreen(items: itemRepository.items, onTap: onItemTapped),
          ],
        ));
  }
}

class TopNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(child: Text("Follow", style: TextStyle(fontSize: 16))),
            SizedBox(width: 8),
            Flexible(child: Text("Market", style: TextStyle(fontSize: 16))),
            SizedBox(width: 8),
            Flexible(child: Text("Nearby", style: TextStyle(fontSize: 16))),
          ],
        ),
      ],
    );
  }
}

class FollowScreen extends StatelessWidget {
  final Future<List<Item>> items;
  final Function(Item) onTap;
  final bool isUserLoggedIn;

  FollowScreen({
    @required this.items,
    @required this.onTap,
    @required this.isUserLoggedIn,
  });

  @override
  Widget build(BuildContext context) {
    return isUserLoggedIn
        ? FutureBuilder(
            future: items,
            builder: (_, AsyncSnapshot<List<Item>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                List<Item> items = snapshot.data;
                return ItemStaggeredGridView(items: items, onTap: onTap);
              }
            },
          )
        : SignUpExperience();
  }
}

class MarketplaceScreen extends StatelessWidget {
  final Future<List<Item>> items;
  final Function(Item) onTap;

  MarketplaceScreen({
    @required this.items,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: items,
      builder: (ctx, AsyncSnapshot<List<Item>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          List<Item> items = snapshot.data;
          return ItemStaggeredGridView(items: items, onTap: onTap);
        }
      },
    );
  }
}

class ItemStaggeredGridView extends StatelessWidget {
  const ItemStaggeredGridView({
    Key key,
    @required this.items,
    @required this.onTap,
  }) : super(key: key);

  final List<Item> items;
  final Function(Item p1) onTap;

  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.count(
      crossAxisCount: 2,
      children: List.generate(
        items.length,
        (index) => ItemWidget(
          item: items[index],
          onTap: onTap,
        ),
      ),
      staggeredTiles: List.generate(
        items.length,
        (index) => StaggeredTile.fit(1),
      ),
    );
  }
}

extension ListEx on List<int> {
  int pickRandom(int length) {
    return this[Random().nextInt(length - 1)];
  }
}

class SignUpExperience extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Text(
          "Please sign in",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
