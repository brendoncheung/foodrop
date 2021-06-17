import 'package:flutter/material.dart';
import 'package:foodrop/core/models/item.dart';
import 'package:foodrop/core/services/database.dart';

class ItemScreen extends StatefulWidget {
  ItemScreen({this.db, this.item});
  final Item item;
  final Database db;

  @override
  _ItemScreenState createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
  @override
  void initState() {
    // TODO: implement initState
    if (item != null) {
      _tecName.text = item.name;
      _tecPrice.text = item.price.toString();
      setState(() {});
    }
    super.initState();
  }

  Item get item => widget.item;
  TextEditingController _tecName = TextEditingController();
  TextEditingController _tecPrice = TextEditingController();
  TextEditingController _Description = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // final _business = Provider.of<Database>(context, listen: false);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(widget.item.name),
      // ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Image.network(widget.item.photoUrl),
                Padding(
                  padding: EdgeInsets.only(
                      top: size.height / 15, left: 10, right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () => Navigator.of(context).pop(),
                          icon: Icon(
                            Icons.chevron_left,
                            size: 48,
                          )),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Form(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      controller: _tecName,
                      decoration: InputDecoration(labelText: "Name"),
                    ),
                    TextFormField(
                      controller: _tecPrice,
                      decoration: InputDecoration(labelText: "Price"),
                    ),
                    ListTile(
                      title: Align(
                          alignment: Alignment(-1.17, 0.0),
                          child: Text("Category: ${widget.item.categoryName}")),
                      // subtitle: Text(widget.item.categoryName),
                      onTap: () {},
                      trailing: Icon(Icons.chevron_right),
                    ),
                    Divider(
                      thickness: 2,
                    ),
                    TextFormField(
                      maxLines: 10,
                      decoration: InputDecoration(
                        labelText: "Description",
                      ),
                    ),
                    SizedBox(height: 10),
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
