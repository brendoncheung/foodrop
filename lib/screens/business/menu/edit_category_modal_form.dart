import 'package:flutter/material.dart';
import 'package:foodrop/core/models/items_category.dart';
import 'package:foodrop/core/services/database.dart';

class EditCategoryModalForm extends StatefulWidget {
  EditCategoryModalForm({this.item, this.businessId, this.db});

  ItemsCategory item;
  String businessId;
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

  @override
  void initState() {
    if (widget.item != null) {
      _tecName.text = widget.item.name;
      _tecIndex.text = widget.item.index.toString();
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
    // final _business = Provider.of<Business>(context, listen: false);
    category = ItemsCategory(businessId: widget.businessId);
    // return _buildCategoryModalForm(context);
    return SingleChildScrollView(
      child: Container(
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
                Form(
                  key: _categoryModalFormKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _tecName,
                        decoration: InputDecoration(labelText: "category name"),
                        onSaved: (text) => category.name = text,
                      ),
                      TextFormField(
                        controller: _tecIndex,
                        decoration: InputDecoration(labelText: "index"),
                        onSaved: (text) => category.index = int.tryParse(text),
                      ),
                    ],
                  ),
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
      ),
    );
  }

  _onSubmit(BuildContext context) {
    // final _db = FirestoreDatabase(uid: model.uid);
    // final _db = Provider.of<Database>(context, listen: false);
    _categoryModalFormKey.currentState.save();
    widget.db.setCategory(category: category);
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
