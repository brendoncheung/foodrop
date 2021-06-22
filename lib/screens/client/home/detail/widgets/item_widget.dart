import 'package:flutter/material.dart';
import 'package:foodrop/core/models/item.dart';

class ItemWidget extends StatelessWidget {
  Item item;
  List<String> photoUrls;
  void Function(Item) onTap;

  ItemWidget({this.item, this.onTap, this.photoUrls});

  @override
  Widget build(BuildContext context) {
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
            Expanded(
              child: SplashImage(item: item),
            ),
            SizedBox(height: 8),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 8),
              child: Text(
                item.description,
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
                  CircleAvatar(radius: 10, backgroundImage: NetworkImage(item.businessAvatarUrl)),
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
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Center(child: CircularProgressIndicator());
        },
        fit: BoxFit.cover,
      ),
    );
  }
}
