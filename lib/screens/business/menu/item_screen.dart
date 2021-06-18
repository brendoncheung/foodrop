import 'package:flutter/material.dart';
import 'package:foodrop/core/models/item.dart';
import 'package:foodrop/core/models/items_category.dart';
import 'package:foodrop/core/services/database.dart';
import 'package:foodrop/screens/business/menu/category_selection_screen.dart';
import 'package:provider/provider.dart';

class ItemScreen extends StatefulWidget {
  ItemScreen({this.db, this.item, this.categories});
  final Item item;
  final Database db;
  final List<ItemsCategory> categories;

  @override
  _ItemScreenState createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
  final _menuItemFormKey = GlobalKey<FormState>();

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
  TextEditingController _tecDescription = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    _tecName.dispose();
    _tecPrice.dispose();
    _tecDescription.dispose();
    super.dispose();
  }

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
              key: _menuItemFormKey,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      onSaved: (text) => widget.item.name = text,
                      controller: _tecName,
                      decoration: InputDecoration(labelText: "Name"),
                      // onChanged: (text) => widget.item.name = text,
                    ),
                    TextFormField(
                      onSaved: (text) =>
                          widget.item.price = double.tryParse(text),
                      controller: _tecPrice,
                      decoration: InputDecoration(labelText: "Price"),
                      // onChanged: (text) =>
                      //     widget.item.price = double.tryParse(text),
                    ),
                    ListTile(
                      title: Align(
                          alignment: Alignment(-1.17, 0.0),
                          child: Text("Category: ${widget.item.categoryName}")),
                      // subtitle: Text(widget.item.categoryName),
                      onTap: () {
                        final result = Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => Provider<List<ItemsCategory>>(
                              create: (context) => widget.categories,
                              child: Consumer<List<ItemsCategory>>(
                                builder: (_, categories, __) =>
                                    CategorySelectionScreen(
                                        categories: categories,
                                        defaultCategoryName: item.categoryName,
                                        finalSelectedCategory:
                                            (selectedCategory) {
                                          setState(() {
                                            widget.item.categoryName =
                                                selectedCategory.name;
                                            widget.item.categoryId =
                                                selectedCategory.docId;
                                          });
                                        }),
                              ),
                            ),
                          ),
                        );
                      },
                      trailing: Icon(Icons.chevron_right),
                    ),
                    Divider(
                      thickness: 2,
                    ),
                    TextFormField(
                      // onChanged: (text) => widget.item.description = text,
                      onSaved: (text) => widget.item.description = text,
                      controller: _tecDescription,
                      maxLines: 10,
                      decoration: InputDecoration(
                        labelText: "Description",
                      ),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: _onSaveAndClose,
                      child: Text("Save and Close!"),
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

  void _onSaveAndClose() {
    try {
      _menuItemFormKey.currentState.save();
      widget.db.setItem(item: widget.item);
    } catch (e) {
      print("somethign is wrong");
    }

    //Navigator.of(context).pop();
  }
}
