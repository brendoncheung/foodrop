import 'package:flutter/material.dart';
import 'package:foodrop/core/models/item.dart';

class ItemWidget extends StatelessWidget {
  final Item item;
  final Function(Item item) onTap;

  ItemWidget({@required this.item, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap(item);
      },
      child: Card(
        color: Colors.grey[800],
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
                      child: Title(item: item),
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

class Title extends StatelessWidget {
  final Item item;

  Title({this.item});

  @override
  Widget build(BuildContext context) {
    return Text(
      item.name,
      style: TextStyle(color: Colors.white),
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
          style: TextStyle(fontSize: 12, color: Colors.white),
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
            style: TextStyle(fontSize: 12, color: Colors.white),
          ),
        )
      ],
    );
  }
}
