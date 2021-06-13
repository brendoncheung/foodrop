import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:foodrop/core/models/items_category.dart';

class EditCategoryModalForm<T> extends StatefulWidget {
  EditCategoryModalForm({this.items});
  List<T> items;

  @override
  _EditCategoryModalFormState createState() => _EditCategoryModalFormState();
}

class _EditCategoryModalFormState extends State<EditCategoryModalForm> {
  @override
  Widget build(BuildContext context) {
    return _buildAddNewCategoryWidget(context);
  }

  Widget _buildAddNewCategoryWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: ActionChip(
        shadowColor: Colors.black,
        label: Text("Add"),
        avatar: Icon(Icons.add),
        backgroundColor: Colors.amber,
        onPressed: () => showModalBottomSheet(
            context: context,
            builder: (context) {
              return _buildCategoryModalForm(context);
            }),
      ),
    );
  }

  Widget _buildCategoryModalForm(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        TextField(
          decoration: InputDecoration(labelText: "category name"),
        ),
        TextField(
          decoration: InputDecoration(labelText: "order"),
        ),
        ElevatedButton(onPressed: () {}, child: Text("Submit")),
        Divider(
          thickness: 1,
        ),
        // ReorderableListView(children: children, onReorder: onReorder)
        ReorderableListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: widget.items.length,
          onReorder: (int newIndex, int oldIndex) => setState(() {}),
          itemBuilder: (context, index) {
            ItemsCategory item = widget.items[index];
            return ListTile(
              key: Key(
                item.index.toString(),
              ),
              title: Text(item.name),
            );
          },
        )
      ],
    );
  }
}
