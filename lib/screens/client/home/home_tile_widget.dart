import 'package:flutter/material.dart';
import 'package:foodrop/core/models/home_tile.dart';

class HomeTileWidget extends StatelessWidget {
  HomeTile _item;

  HomeTileWidget({HomeTile item}) : _item = item;

  @override
  Widget build(BuildContext context) {
    PaintingBinding.instance.imageCache.clear();
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("${_item.username} selected"),
        ));
      },
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: Colors.grey[800],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: Placeholder()
                // child: Image.network(
                //   _item.imageurl,
                //   loadingBuilder: (context, child, loadingProgress) {
                //     if (loadingProgress == null) return child;
                //     return Center(child: CircularProgressIndicator());
                //   },
                //   fit: BoxFit.cover,
                // ),

                ),
            SizedBox(height: 8),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 8),
              child: Text(
                _item.title,
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
                  Flexible(
                    flex: 2,
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      children: [
                        CircleAvatar(
                            radius: 10,
                            backgroundImage: NetworkImage(_item.avatarurl)),
                        SizedBox(width: 8),
                        Text(_item.username,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 12, color: Colors.grey[300])),
                        SizedBox(width: 8),
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Wrap(
                      children: [
                        Icon(Icons.favorite, color: Colors.red, size: 16),
                        SizedBox(width: 8),
                        Text(_item.numOfFavourites.toString(),
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 12, color: Colors.grey[300]))
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
