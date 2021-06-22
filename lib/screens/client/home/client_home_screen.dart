import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:foodrop/core/models/item.dart';
import 'package:foodrop/core/services/firestore_service.dart';
import 'package:foodrop/core/services/repositories/image_repository.dart';
import 'package:foodrop/core/services/repositories/item_repository.dart';
import 'package:foodrop/screens/client/home/detail/home_tile_detail_screen.dart';
import 'package:foodrop/screens/common_widgets/asyncSnapshot_Item_Builder.dart';
import 'package:provider/provider.dart';

import 'detail/widgets/item_widget.dart';

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
              print(snapshot.data.toString());
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (_, index) {
                    return ItemWidget(
                      item: snapshot.data[index],
                      photoUrls: [],
                    );
                  });
            }
          },
        ));
  }
}
