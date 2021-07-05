import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foodrop/core/models/items_category.dart';
import 'package:foodrop/screens/business/common_widgets/show_exception_alert_dialog.dart';

class CategorySelectionScreen extends StatefulWidget {
  CategorySelectionScreen(
      {this.categories, this.defaultCategoryName, this.onSelectedCategory});
  final List<ItemsCategory> categories;
  final String defaultCategoryName;

  final Function(ItemsCategory) onSelectedCategory;

  @override
  _CategorySelectionScreenState createState() =>
      _CategorySelectionScreenState();
}

class _CategorySelectionScreenState extends State<CategorySelectionScreen> {
  ItemsCategory _selectedCategory;
  @override
  void initState() {
    // TODO: implement initState
    if (widget.categories != null && widget.defaultCategoryName != null) {
      _selectedCategory = widget.categories
          .where((element) => element.name == widget.defaultCategoryName)
          .toList()[0];
    }
    {
      _selectedCategory = widget.categories
          .map((e) => e)
          .toList()[0]; // where there is no defaultCategoryName
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
            widget.onSelectedCategory(_selectedCategory);
            return true;
          },
          child: _buildBody(context),
        ));
  }

  _buildBody(BuildContext context) {
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
    // try {
    //   return ListView(
    //       children: widget.categories
    //           .map((category) => RadioListTile(
    //                 title: Text(category.name),
    //                 value: category,
    //                 groupValue: _selectedCategory,
    //                 onChanged: (category) => setState(() {
    //                   _selectedCategory = category;
    //                 }),
    //               ))
    //           .toList());
    // } catch (e) {
    //   showExceptionAlertDialog(context,
    //       exception: e, title: "Problem loading data");
    //   Navigator.of(context).pop();
    // }
  }
}
