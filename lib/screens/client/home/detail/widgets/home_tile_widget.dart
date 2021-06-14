import 'package:flutter/material.dart';
import 'package:foodrop/core/models/menu.dart';

class HomeTileWidget extends StatelessWidget {
  Menu _tile;
  void Function(Menu) _onTileTapped;

  HomeTileWidget({Menu tile, void Function(Menu) onTileTapped}) {
    this._tile = tile;
    this._onTileTapped = onTileTapped;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${_tile.username} selected")));
        _onTileTapped(_tile);
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
            Expanded(
              child: FittedBox(
                fit: BoxFit.cover,
                child: Image.network(
                  _tile.imageurl,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(child: CircularProgressIndicator());
                  },
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 8),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 8),
              child: Text(
                _tile.title,
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
                  CircleAvatar(radius: 10, backgroundImage: NetworkImage(_tile.avatarurl)),
                  SizedBox(width: 8),
                  Text(_tile.username, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 12, color: Colors.grey[300])),
                  SizedBox(width: 8),
                  Icon(Icons.favorite, color: Colors.red, size: 16),
                  SizedBox(width: 8),
                  Text(_tile.numOfFavourites.toString(), overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 12, color: Colors.grey[300]))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
