import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:foodrop/core/models/home_tile.dart';
import 'package:foodrop/screens/client/home/detail/home_tile_detail_screen.dart';

import 'widget/home_tile_widget.dart';

class ClientHomeScreen extends StatefulWidget {
  const ClientHomeScreen({Key key}) : super(key: key);

  @override
  _ClientHomeScreenState createState() => _ClientHomeScreenState();
}

class _ClientHomeScreenState extends State<ClientHomeScreen> {
  final _scrollController = ScrollController();

  final image_source = "https://source.unsplash.com/random/1600x900";
  String Function(int i) avatar_source = (i) {
    return "https://i.pravatar.cc/300";
  };

  bool _fabVisible = true;

  @override
  Widget build(BuildContext context) {
    List<HomeTile> _items = [
      HomeTile(title: "Chicken fried", image_url: image_source, avatar_url: avatar_source(1), username: "Batma Donuts", favourite: 23, price: 4.99, numSold: 89),
      HomeTile(title: "Smoothie", image_url: image_source, avatar_url: avatar_source(2), username: "Superman Sandwishes", favourite: 56, price: 12.99, numSold: 100),
      HomeTile(title: "Spicy dumpling", image_url: image_source, avatar_url: avatar_source(3), username: "Obama Ice Cream", favourite: 552, price: 29.99, numSold: 900),
      HomeTile(title: "Prime ribs", image_url: image_source, avatar_url: avatar_source(4), username: "Biden sushi", favourite: 92, price: 24.99, numSold: 657),
      HomeTile(title: "Thai food", image_url: image_source, avatar_url: avatar_source(5), username: "Clinton smoothies", favourite: 56, price: 7.99, numSold: 451),
      HomeTile(title: "Korean BBQ", image_url: image_source, avatar_url: avatar_source(6), username: "Conan salad bar", favourite: 76, price: 56.99, numSold: 98),
      HomeTile(title: "Snacks", image_url: image_source, avatar_url: avatar_source(7), username: "Brendon mexican", favourite: 34, price: 9.99, numSold: 656),
      HomeTile(title: "Hello", image_url: image_source, avatar_url: avatar_source(8), username: "50cent pizzaria", favourite: 90, price: 5.99, numSold: 6790),
    ];

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
      floatingActionButton: AnimatedOpacity(
        opacity: _fabVisible ? 0 : 1.0,
        duration: Duration(microseconds: 500),
        curve: Curves.linear,
        child: FloatingActionButton(
          onPressed: () {},
          child: Icon(
            Icons.add,
            color: Colors.black,
          ),
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
      body: Container(
        color: Colors.grey[900],
        child: GridView.builder(
          controller: _scrollController,
          padding: EdgeInsets.all(7),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 7.0,
            mainAxisSpacing: 7.0,
          ),
          itemBuilder: (context, index) {
            return HomeTileWidget(
                tile: _items[index],
                onTileTapped: (tile) => Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => HomeTileDetailScreen(
                          homeTile: tile,
                        ))));
          },
          itemCount: _items.length,
        ),
      ),
    );
  }
}
