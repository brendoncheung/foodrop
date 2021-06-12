import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'empty_content.dart';

typedef ItemWidgetBuilder<T> = Widget Function(BuildContext context, T item);

class AsyncSnapshotItemBuilder<T> extends StatelessWidget {
  AsyncSnapshotItemBuilder(
      {this.snapshot,
      this.itemBuilder,
      this.withDivider = true,
      this.scrollDirection = Axis.vertical});

  final AsyncSnapshot snapshot;
  final ItemWidgetBuilder<T> itemBuilder;
  final bool withDivider;
  final Axis scrollDirection;

  @override
  Widget build(BuildContext context) {
    if (snapshot.hasData) {
      final List<T> items = snapshot.data;
      if (items.isNotEmpty) {
        return _buildList(items);
      } else {
        return EmptyContent();
      }
    } else if (snapshot.hasError) {
      return EmptyContent(
        title: 'Something went wrong',
        message: 'Can\'t load items right now',
      );
    }
    return Center(child: CircularProgressIndicator());
  }

  Widget _buildList(List<T> items) {
    if (withDivider) {
      return ListView.separated(
          itemBuilder: (context, index) {
            if (index == 0 || index == items.length + 1) {
              return Container();
            }
            return itemBuilder(context, items[index - 1]);
          },
          separatorBuilder: (context, index) => Divider(height: 0.5),
          itemCount: items.length + 2);
    } else {
      return ListView.builder(
          scrollDirection: scrollDirection,
          itemBuilder: (context, index) {
            print(": $index");
            if (index == 0) {
              return _buildAddNewCategoryWidget(context);
            }
            return itemBuilder(context, items[index - 1]);
          },
          itemCount: items.length + 1);
    }
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
    return Stack(children: [
      Expanded(
        child: Container(
          // height: 200,
          color: Colors.amber,
        ),
      ),
      Align(
          alignment: Alignment.topRight,
          child: IconButton(
              onPressed: Navigator.of(context).pop, icon: Icon(Icons.cancel)))
    ]);
  }
}
