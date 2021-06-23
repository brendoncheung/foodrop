import 'package:flutter/material.dart';
import 'package:foodrop/core/models/item.dart';

class ItemWidget extends StatelessWidget {
  Item item;
  Function onTap;

  ItemWidget({@required this.item, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 4,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              flex: 3,
              child: SplashImage(
                photoUrl: item.photoUrl.first,
              ),
            ),
            Flexible(
              fit: FlexFit.loose,
              child: Padding(
                padding: EdgeInsets.all(6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: Text(item.name),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 5,
                            child: BusinessAvatarWidget(
                              avatarUrl: item.businessAvatarUrl,
                              businessName: item.tradingName,
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: FavoritesStateWidget(
                              numOfLikes: item.numOfFavs,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SplashImage extends StatelessWidget {
  String photoUrl;

  SplashImage({@required this.photoUrl});

  @override
  Widget build(BuildContext context) {
    return Ink.image(
      height: 100,
      fit: BoxFit.fitWidth,
      image: NetworkImage(photoUrl),
    );
  }
}

class FavoritesStateWidget extends StatelessWidget {
  int numOfLikes;
  bool isFavorited;

  FavoritesStateWidget({@required this.numOfLikes, this.isFavorited = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          numOfLikes.toString(),
          style: TextStyle(fontSize: 12),
        ),
        SizedBox(
          width: 4,
        ),
        Icon(
          Icons.favorite_border_rounded,
          size: 14,
          color: isFavorited ? Colors.red : Colors.grey,
        ),
      ],
    );
  }
}

class BusinessAvatarWidget extends StatelessWidget {
  String avatarUrl;
  String businessName;

  BusinessAvatarWidget({@required this.avatarUrl, @required this.businessName});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          fit: FlexFit.loose,
          child: CircleAvatar(
            maxRadius: 15,
            backgroundImage: NetworkImage('https://i.pravatar.cc/300'),
          ),
        ),
        SizedBox(
          width: 4,
        ),
        Expanded(
          flex: 5,
          child: Text(
            businessName,
            style: TextStyle(fontSize: 12),
          ),
        )
      ],
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
//           Flexible(
//             fit: FlexFit.loose,
//             child: Padding(
//               padding: EdgeInsets.all(4),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   Expanded(
//                     child: Text("Flutter demo"),
//                   ),
//                   Expanded(
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         Expanded(
//                           flex: 5,
//                           child: BusinessAvatarWidget(),
//                         ),
//                         Expanded(
//                           flex: 2,
//                           child: FavoritesStateWidget(),
//                         )
//                       ],
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ),
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
//       ],
//     );
//   }
// }

// class BusinessAvatarWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Flexible(
//           fit: FlexFit.loose,
//           child: CircleAvatar(
//             maxRadius: 15,
//             backgroundImage: NetworkImage('https://i.pravatar.cc/300'),
//           ),
//         ),
//         SizedBox(
//           width: 4,
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
