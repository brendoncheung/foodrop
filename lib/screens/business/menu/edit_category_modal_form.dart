import 'package:flutter/material.dart';
import 'package:foodrop/core/models/items_category.dart';
import 'package:foodrop/core/services/database.dart';

class EditCategoryModalForm extends StatefulWidget {
  EditCategoryModalForm({this.item, this.db});

  ItemsCategory item;
  // String businessId;
  Database db;

  @override
  _EditCategoryModalFormState createState() => _EditCategoryModalFormState();
}

class _EditCategoryModalFormState extends State<EditCategoryModalForm> {
  final TextEditingController _tecName = TextEditingController();
  final TextEditingController _tecIndex = TextEditingController();

  final FocusNode _fnName = FocusNode();
  final FocusNode _fnIndex = FocusNode();
  ItemsCategory category;
  // if (widget.item == null) {
  // category = ItemsCategory(businessId: widget.businessId);
  // // _isActive = category.isActive;
  // }
  @override
  void initState() {
    if (widget.item != null) {
      _tecName.text = widget.item.name;
      _tecIndex.text = widget.item.index.toString();
    }

    if (widget.item != null) {
      category = widget.item;
      // category.businessId = widget.businessId;
      // _isActive = category.isActive;
    }

    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _tecName.dispose();
    _tecIndex.dispose();
    _fnIndex.dispose();
    _fnName.dispose();
    super.dispose();
  }

  final _categoryModalFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      color: Colors.amber,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Container(
          color: Colors.amber,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: Icon(Icons.cancel),
                    onPressed: Navigator.of(context).pop,
                  )),
              // Row(
              //   children: [
              //     // TextButton(child: Text(category.name)),
              //     // Text(category.name),
              //     Container(
              //       color: Colors.grey,
              //       child: SizedBox(
              //         width: size.width * 0.9,
              //         // height: 200,
              //         child: SwitchListTile(
              //             dense: true,
              //             value: category.isActive,
              //             onChanged: (value) {
              //               print(value);
              //               setState(() {
              //                 category.isActive = value;
              //               });
              //             }),
              //       ),
              //     ),
              //   ],
              // ),
              Form(
                key: _categoryModalFormKey,
                child: Container(
                  // height: 150,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            // width: 100,
                            child: TextFormField(
                              controller: _tecName,
                              decoration:
                                  InputDecoration(labelText: "category name"),
                              onSaved: (text) => category.name = text,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            width: 80,
                            child: TextFormField(
                              controller: _tecIndex,
                              decoration: InputDecoration(labelText: "index"),
                              onSaved: (text) =>
                                  category.index = int.tryParse(text),
                            ),
                          ),
                          Container(
                            // color: Colors.grey,
                            child: SizedBox(
                              width: 100,
                              // height: 200,
                              child: SwitchListTile(
                                  dense: true,
                                  value: category.isActive,
                                  onChanged: (value) {
                                    print(value);
                                    setState(() {
                                      category.isActive = value;
                                    });
                                  }),
                            ),
                          ),
                        ],
                      ),
                      // SwitchListTile(
                      //     dense: true,
                      //     value: category.isActive,
                      //     onChanged: (value) {
                      //       print(value);
                      //       setState(() {
                      //         category.isActive = value;
                      //       });
                      //     }),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              ElevatedButton(
                  onPressed: () => _onSubmit(context), child: Text("Submit")),
              // ReorderableListView(children: children, onReorder: onReorder)
              // ReorderableListView.builder(
              //   scrollDirection: Axis.vertical,
              //   shrinkWrap: true,
              //   itemCount: widget.items.length,
              //   onReorder: (int newIndex, int oldIndex) => setState(() {}),
              //   itemBuilder: (context, index) {
              //     ItemsCategory item = widget.items[index];
              //     return ListTile(
              //       key: Key(
              //         item.index.toString(),
              //       ),
              //       title: Text(item.name),
              //     );
              //   },
              // )
            ],
          ),
        ),
      ),
    );
  }

  _onSubmit(BuildContext context) {
    try {
      _categoryModalFormKey.currentState.save();
      widget.db.setCategory(category: category);
      Navigator.of(context).pop();
      // Scaffold.of(context).showSnackBar(
      //   SnackBar(
      //     content: Text("Updated Successfully"),
      //   ),
      // );
    } catch (e) {
      print(e);
      Navigator.of(context).pop();
      // Scaffold.of(context).showSnackBar(
      //   SnackBar(
      //     content: Text("Problem Encountererd"),
      //   ),
      // );
    }
  }

  // Widget _buildAddNewCategoryWidget(BuildContext context) {
  //   return Padding(
  //     padding: EdgeInsets.all(10),
  //     child: ActionChip(
  //       shadowColor: Colors.black,
  //       label: Text("Add"),
  //       avatar: Icon(Icons.add),
  //       backgroundColor: Colors.amber,
  //       onPressed: () => showModalBottomSheet(
  //           isScrollControlled: true,
  //           context: context,
  //           builder: (context) {
  //             return _buildCategoryModalForm(context);
  //           }),
  // }

}
