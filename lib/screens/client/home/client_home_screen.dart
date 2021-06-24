import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:foodrop/core/models/item.dart';
import 'package:foodrop/core/services/repositories/image_repository.dart';
import 'package:foodrop/core/services/repositories/item_repository.dart';
import 'package:foodrop/screens/client/home/detail/detail_item_screen.dart';
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
      body: FutureBuilder(
        future: itemRepository.items,
        builder: (ctx, AsyncSnapshot<List<Item>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            List<Item> items = snapshot.data;
            print(items.first.toString());
            return HomepageGridView(items: items);
          }
        },
      ),
    );
  }
}

class HomepageGridView extends StatelessWidget {
  const HomepageGridView({
    Key key,
    @required this.items,
  }) : super(key: key);

  final List<Item> items;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      children: List.generate(
        items.length,
        (index) => ItemWidget(
          item: items[index],
          onTap: (item) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => DetailItemScreen(
                  item: item,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
