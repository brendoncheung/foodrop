import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foodrop/core/models/items_category.dart';

class CategorySelectionScreen extends StatefulWidget {
  CategorySelectionScreen(
      {this.categories, this.defaultCategoryName, this.finalSelectedCategory});
  final List<ItemsCategory> categories;
  final String defaultCategoryName;

  final Function(ItemsCategory) finalSelectedCategory;

  @override
  _CategorySelectionScreenState createState() =>
      _CategorySelectionScreenState();
}

class _CategorySelectionScreenState extends State<CategorySelectionScreen> {
  ItemsCategory _selectedCategory;
  @override
  void initState() {
    // TODO: implement initState
    if (widget.categories != null) {
      _selectedCategory = widget.categories
          .where((element) => element.name == widget.defaultCategoryName)
          .toList()[0];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Select category"),
        ),
        //   body: _buildBody(),
        // );
        body: WillPopScope(
          onWillPop: () async {
            widget.finalSelectedCategory(_selectedCategory);
            return true;
          },
          child: _buildBody(),
        ));
  }

  _buildBody() {
    return ListView(
        children: widget.categories
            .map((category) => RadioListTile(
                  title: Text(category.name),
                  value: category,
                  groupValue: _selectedCategory,
                  onChanged: (category) => setState(() {
                    _selectedCategory = category;
                  }),
                ))
            .toList());
  }
}
