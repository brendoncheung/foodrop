import 'package:flutter/material.dart';
import 'package:foodrop/core/models/menu.dart';

class PriceAndLikeBar extends StatelessWidget {
  const PriceAndLikeBar({
    Key key,
    @required Item homeTile,
  })  : _homeTile = homeTile,
        super(key: key);

  final Item _homeTile;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          fit: FlexFit.tight,
          flex: 1,
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Text("\$${_homeTile.price.toString()}", style: TextStyle(color: Colors.red, fontSize: 16)),
          ),
        ),
        Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(Icons.favorite, color: Colors.red),
                SizedBox(
                  width: 8,
                ),
                Text(_homeTile.favourite.toString(), style: TextStyle(fontSize: 16, color: Colors.white)),
              ],
            ),
          ),
        )
      ],
    );
  }
}
