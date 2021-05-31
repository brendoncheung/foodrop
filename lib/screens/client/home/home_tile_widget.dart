import 'package:flutter/material.dart';

class HomeTileWidget extends StatelessWidget {
  String _main_image_source;
  String _avatar_src;
  String _title;
  String _username;
  String _num_likes;

  HomeTileWidget({String mainSrc}) : _main_image_source = mainSrc;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image.network(
              _main_image_source,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(child: CircularProgressIndicator());
              },
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 0, horizontal: 8),
            child: Text(
              "Yummy food",
              style: TextStyle(color: Colors.white),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Row(
              children: [
                Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 16,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "Badass mofo",
                  style: TextStyle(fontSize: 12, color: Colors.grey[300]),
                ),
                SizedBox(
                  width: 8,
                ),
                Icon(
                  Icons.favorite,
                  color: Colors.red,
                  size: 16,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "436",
                  style: TextStyle(fontSize: 12, color: Colors.grey[300]),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
