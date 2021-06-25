// import 'package:flutter/material.dart';
// import 'package:foodrop/core/models/menu.dart';
// import 'package:foodrop/screens/client/home/detail/widgets/price_and_like_bar.dart';
// import 'package:foodrop/screens/client/home/detail/widgets/product_detail.dart';
// import 'package:foodrop/screens/client/home/detail/widgets/product_image.dart';
// import 'package:foodrop/screens/client/home/detail/widgets/product_review.dart';
// import 'package:foodrop/screens/client/home/detail/widgets/vendor_tile.dart';
//
// class HomeTileDetailScreen extends StatelessWidget {
//   static const String ROUTE_NAME = "home/detail";
//
//   Menu menu;
//
//   HomeTileDetailScreen({Menu homeTile}) {
//     this.menu = homeTile;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     print(menu.numSold);
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.grey[900],
//         title: Text(menu.title),
//         actions: [
//           IconButton(
//               onPressed: () {},
//               icon: Icon(
//                 Icons.share_rounded,
//                 color: Colors.white,
//               )),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {},
//         child: Icon(Icons.add_rounded),
//       ),
//       backgroundColor: Colors.grey[900],
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               ProductImage(homeTile: menu),
//               SizedBox(height: 8),
//               PriceAndLikeBar(homeTile: menu),
//               Row(
//                 children: [
//                   SizedBox(width: 8),
//                   Text("${menu.numSold.toString()} sold",
//                       style: TextStyle(color: Colors.white, fontSize: 16))
//                 ],
//               ),
//               SizedBox(height: 8),
//               VendorTile(
//                 homeTile: menu,
//                 onTap: () {
//                   ScaffoldMessenger.of(context).hideCurrentSnackBar();
//                   ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(content: Text("vendor tile selected")));
//                 },
//               ),
//               SizedBox(height: 8),
//               ProductReview(
//                 onTap: () {
//                   ScaffoldMessenger.of(context).hideCurrentSnackBar();
//                   ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(content: Text("product review tile selected")));
//                 },
//               ),
//               SizedBox(height: 8),
//               Container(
//                 color: Colors.grey[800],
//                 padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//                 child: SizedBox(
//                   width: double.infinity,
//                   height: 48,
//                   child: Row(
//                     children: [
//                       Align(
//                         alignment: Alignment.topLeft,
//                         child: Text(
//                           "Product Suggestion (5)",
//                           style: TextStyle(fontSize: 18, color: Colors.white),
//                         ),
//                       ),
//                       Expanded(
//                         child: Align(
//                           alignment: Alignment.centerRight,
//                           child: Icon(
//                             Icons.chevron_right_outlined,
//                             color: Colors.white,
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(height: 8),
//               ProductDetail(),
//               SizedBox(height: 8),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
