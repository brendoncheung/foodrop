import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:foodrop/core/models/menu.dart';
import 'package:foodrop/core/services/firestore_service.dart';
import 'package:foodrop/core/services/repositories/menu_repository.dart';
import 'package:foodrop/screens/client/home/detail/home_tile_detail_screen.dart';
import 'package:provider/provider.dart';

import 'detail/widgets/home_tile_widget.dart';

class ClientHomeScreen extends StatefulWidget {
  const ClientHomeScreen({Key key}) : super(key: key);

  @override
  _ClientHomeScreenState createState() => _ClientHomeScreenState();
}

class _ClientHomeScreenState extends State<ClientHomeScreen> with SingleTickerProviderStateMixin {
  final _scrollController = ScrollController();

  final mealRepository = ItemRepository(FirebaseFirestore.instance);

  final image_source = "https://source.unsplash.com/random/1600x900";
  String Function(int i) avatar_source = (i) {
    return "https://i.pravatar.cc/300";
  };

  bool _fabVisible = true;

  @override
  Widget build(BuildContext context) {
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection == ScrollDirection.forward) {
        setState(() {
          _fabVisible = false;
        });
      } else if (_scrollController.position.userScrollDirection == ScrollDirection.reverse) {
        setState(() {
          _fabVisible = true;
        });
      }
    });

    return Scaffold(
      floatingActionButton: Opacity(
        opacity: _fabVisible ? 1 : 0,
        child: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.add, color: Colors.black),
          backgroundColor: Colors.white,
        ),
      ),
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey[900],
        title: Text("Home"),
        actions: [
          Padding(
            padding: EdgeInsets.all(20.0),
            child: GestureDetector(
              child: Icon(Icons.search),
            ),
          )
        ],
      ),
      body: StreamBuilder(
        stream: mealRepository.itemsLive,
        builder: (_, AsyncSnapshot<List<Item>> snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }
          List<Item> menus = snapshot.data;
          print(menus);
          return Text("hello");
        },
      ),
    );
  }
}
