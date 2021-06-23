import 'package:flutter/material.dart';
import 'package:foodrop/core/models/item.dart';

class ItemWidget extends StatelessWidget {
  Item item;
  List<String> photoUrls;
  void Function(Item) onTap;

  ItemWidget({this.item, this.onTap, this.photoUrls});

  @override
  Widget build(BuildContext context) {
    print("to string ${item.toString()}");
    return GestureDetector(
      onTap: () {},
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: Colors.grey[800],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // TODO: Splash image  is causing problems
            Expanded(
              child: SplashImage(item: item),
            ),
            SizedBox(height: 8),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 8),
              child: Text(
                "hello",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.white),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 10,
                  ),
                  SizedBox(width: 8),
                  Text(item.businessId, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 12, color: Colors.grey[300])),
                  SizedBox(width: 8),
                  Icon(Icons.favorite, color: Colors.red, size: 16),
                  SizedBox(width: 8),
                  Text(item.numOfFavs.toString(), overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 12, color: Colors.grey[300]))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SplashImage extends StatelessWidget {
  const SplashImage({
    Key key,
    @required this.item,
  }) : super(key: key);

  final Item item;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.cover,
      child: Image.network(
        item.photoUrl.first,
        fit: BoxFit.cover,
      ),
    );
  }
}
// class ItemWidget extends StatelessWidget {
//   String name;
//   ItemWidget(this.name);

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       clipBehavior: Clip.antiAlias,
//       elevation: 4,
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Expanded(
//             flex: 3,
//             child: Ink.image(
//               height: 100,
//               fit: BoxFit.fitWidth,
//               image: NetworkImage("https://source.unsplash.com/random"),
//             ),
//           ),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 SizedBox(
//                   height: 4,
//                 ),
//                 Expanded(
//                   child: Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 4),
//                     child: Text("Flutter demo"),
//                   ),
//                 ),
//                 Expanded(
//                   child: Row(
//                     children: [
//                       Expanded(
//                         flex: 5,
//                         child: BusinessAvatarWidget(),
//                       ),
//                       Expanded(
//                         flex: 2,
//                         child: FavoritesStateWidget(),
//                       )
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           ),
//           SizedBox(
//             height: 8,
//           )
//         ],
//       ),
//     );
//   }
// }

// class FavoritesStateWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.end,
//       children: [
//         Text(
//           "123",
//           style: TextStyle(fontSize: 12),
//         ),
//         Icon(
//           Icons.favorite_border_rounded,
//           size: 14,
//         ),
//         SizedBox(
//           width: 4,
//         )
//       ],
//     );
//   }
// }

// class BusinessAvatarWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         SizedBox(
//           width: 4,
//         ),
//         Expanded(
//           flex: 1,
//           child: CircleAvatar(
//             maxRadius: 15,
//             backgroundImage: NetworkImage('https://i.pravatar.cc/300'),
//           ),
//         ),
//         Expanded(
//           flex: 5,
//           child: Text(
//             "Yummy Eatery",
//             style: TextStyle(fontSize: 12),
//           ),
//         )
//       ],
//     );
//   }
// }
