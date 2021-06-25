import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
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
            return HomepageStaggeredGridView(
              items: items,
              onTap: (item) => onItemTapped(item),
            );
          }
        },
      ),
    );
  }
}

class HomepageStaggeredGridView extends StatelessWidget {
  final List<Item> items;
  final Function(Item) onTap;

  HomepageStaggeredGridView({
    @required this.items,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.countBuilder(
      crossAxisCount: 2,
      itemCount: items.length,
      itemBuilder: (context, index) => ItemWidget(item: items[index], onTap: onTap),
      staggeredTileBuilder: (index) => StaggeredTile.fit(1),
    );
  }
}


// return GridView.count(
//       crossAxisCount: 2,
//       children: List.generate(
//         items.length,
//         (index) => ItemWidget(
//           item: items[index],
//           onTap: (item) {
//             Navigator.of(context).push(
//               MaterialPageRoute(
//                 builder: (context) => DetailItemScreen(
//                   item: item,
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );