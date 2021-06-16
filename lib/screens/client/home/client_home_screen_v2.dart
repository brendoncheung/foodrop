import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:foodrop/core/models/item.dart';
import 'package:foodrop/core/services/database.dart';
import 'package:foodrop/screens/common_widgets/asyncSnapshot_Item_Builder.dart';
import 'package:provider/provider.dart';

class ClientHomeScreenV2 extends StatefulWidget {
  @override
  _ClientHomeScreenV2State createState() => _ClientHomeScreenV2State();
}

class _ClientHomeScreenV2State extends State<ClientHomeScreenV2> {
  @override
  Widget build(BuildContext context) {
    final _scrollController = ScrollController();

    // final mealRepository = MenuRepository(FirebaseFirestore.instance);

    // final image_source = "https://source.unsplash.com/random/1600x900";
    // String Function(int i) avatar_source = (i) {
    //   return "https://i.pravatar.cc/300";
    // };

    final _db = Provider.of<Database>(context, listen: false);

    bool _fabVisible = true;

    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        setState(() {
          _fabVisible = false;
        });
      } else if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
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
        stream: _db.itemsStream(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              {
                return Center(child: CircularProgressIndicator());
              }
              break;
            case ConnectionState.active:
              {
                return AsyncSnapshotItemBuilder<Item>(
                  withDivider: true,
                  snapshot: snapshot,
                  itemBuilder: (context, item) {
                    return Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      child: ListTile(
                          // tileColor: Colors.green,
                          title: Text(item.name),
                          subtitle: Text("${item.categoryName}"),
                          selectedTileColor: Colors.black26,
                          onTap: () {}),
                    );
                  },
                );
              }
              break;
            default:
              {
                return CircularProgressIndicator();
              }
          }
        },
      ),
    );
  }
}
// }
