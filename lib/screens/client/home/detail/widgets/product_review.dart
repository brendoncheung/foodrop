import 'package:flutter/material.dart';

class ProductReview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text("Product Reviews (5)", style: TextStyle(fontSize: 18)),
                ),
                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Icon(
                      Icons.chevron_right_rounded,
                      color: Colors.grey[500],
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                CircleAvatar(backgroundColor: Colors.orange),
                SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Text("Brendon"), Icon(Icons.star_rate_rounded)],
                )
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Text(
                "At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident,")
          ],
        ),
      ),
    );
  }
}
