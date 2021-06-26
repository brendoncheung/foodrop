import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodrop/core/models/items_category.dart';
import 'package:foodrop/core/services/database/database.dart';
import 'package:foodrop/screens/business/menu/edit_category_modal_form.dart';

import 'empty_content.dart';

typedef ItemWidgetBuilder<T> = Widget Function(BuildContext context, T item);

class AsyncSnapshotItemBuilder<T> extends StatefulWidget {
  AsyncSnapshotItemBuilder({this.snapshot, this.itemBuilder, this.withDivider = true, this.businessId, this.db, this.scrollDirection = Axis.vertical});

  final AsyncSnapshot snapshot;
  final ItemWidgetBuilder<T> itemBuilder;
  final bool withDivider;
  final Axis scrollDirection;
  final String businessId;
  final Database db;

  @override
  _AsyncSnapshotItemBuilderState<T> createState() => _AsyncSnapshotItemBuilderState<T>();
}

class _AsyncSnapshotItemBuilderState<T> extends State<AsyncSnapshotItemBuilder<T>> {
  @override
  Widget build(BuildContext context) {
    if (widget.snapshot.hasData) {
      final List<T> items = widget.snapshot.data;
      if (items.isNotEmpty) {
        return _buildList(items);
      } else {
        return EmptyContent();
      }
    } else if (widget.snapshot.hasError) {
      return EmptyContent(
        title: 'Something went wrong',
        message: 'Can\'t load items right now',
      );
    }
    return Center(child: CircularProgressIndicator());
  }

  Widget _buildList(List<T> items) {
    if (widget.withDivider) {
      return ListView.separated(
          itemBuilder: (context, index) {
            if (index == 0 || index == items.length + 1) {
              return Container();
            }
            return widget.itemBuilder(context, items[index - 1]);
          },
          separatorBuilder: (context, index) => Divider(height: 0.5),
          itemCount: items.length + 2);
    } else {
      // return ReorderableListView.builder(
      //     onReorder: (int oldIndex, int newIndex) {
      //       setState(() {
      //         print("oldIndex: $oldIndex, newIndex: $newIndex");
      //       });
      //     },
      //     scrollDirection: widget.scrollDirection,
      //     itemBuilder: (context, index) {
      //       // if (index == 0) {
      //       //   return EditCategoryModalForm();
      //       // }
      //       return widget.itemBuilder(context, items[index]);
      //     },
      //     itemCount: items.length);

      return ListView.builder(
          scrollDirection: widget.scrollDirection,
          itemBuilder: (context, index) {
            // print(": $index");
            if (index == 0) {
              return Padding(
                padding: EdgeInsets.all(10),
                child: ActionChip(
                  shadowColor: Colors.black,
                  label: Text("Category"),
                  avatar: Icon(Icons.add),
                  backgroundColor: Colors.amber,
                  // onPressed: () => EditCategoryModalForm(items: items),
                  onPressed: () => showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      builder: (context) {
                        return EditCategoryModalForm(
                          item: ItemsCategory(businessId: widget.businessId),
                          // businessId: widget.businessId,
                          db: widget.db,
                        );
                      }),
                ),
              );
              // return EditCategoryModalForm(items: items);
            }
            return widget.itemBuilder(context, items[index - 1]);
          },
          itemCount: items.length + 1);

      // Widget _buildAddNewCategoryWidget(BuildContext context) {
      // return Padding(
      //   padding: EdgeInsets.all(10),
      //   child: ActionChip(
      //     shadowColor: Colors.black,
      //     label: Text("Add"),
      //     avatar: Icon(Icons.add),
      //     backgroundColor: Colors.amber,
      //     onPressed: () => showModalBottomSheet(
      //         isScrollControlled: true,
      //         context: context,
      //         builder: (context) {
      //           return _buildCategoryModalForm(context);
      //         }),
      //   ),
      // );
      // }

    }
  }
}
