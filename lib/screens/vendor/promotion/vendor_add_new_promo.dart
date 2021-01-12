import 'package:flutter/material.dart';

import 'widgets/recurring_day_list.dart';

class VendorAddNewPromo extends StatelessWidget {
  final dayContainerSize = 30.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Promotion"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
//        elevation: 0,
//        flexibleSpace: Image.asset(
//          'assets/images/vendor_screen_images/new_promo_banner.jpg',
//          fit: BoxFit.cover,
//        ),
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//          Text("Enter promo name"),
//        Image.asset(
//          'assets/images/vendor_screen_images/new_promo_banner.jpg',
//          fit: BoxFit.cover,
//        ),
        TextField(
          decoration: InputDecoration(
              labelText: 'Enter promo name', hintText: 'weekend sale'),
        ),
        SizedBox(height: 10),
        Text(
          "Set Recurring",
          style: TextStyle(fontSize: 18),
        ),
        SizedBox(height: 10),
        Container(height: 50, child: RecurringDayList()),
        Divider(
          thickness: 1,
        )
      ]),
    );
  }
}

// ,
