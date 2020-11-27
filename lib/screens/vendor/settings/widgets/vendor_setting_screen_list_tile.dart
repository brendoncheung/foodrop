import 'package:flutter/material.dart';

class VendorSettingScreenListTile extends StatelessWidget {
  VoidCallback _onTapHandler;

  final String _title;
  final String _subtitle;

  VendorSettingScreenListTile({String title, String subtitle, VoidCallback onTapHandler})
      : _title = title,
        _subtitle = subtitle,
        _onTapHandler = onTapHandler;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListTile(
      title: Text(_title, style: Theme.of(context).textTheme.subtitle1),
      subtitle: Text(_subtitle, style: Theme.of(context).textTheme.caption),
      trailing: IconButton(
        icon: Icon(Icons.edit),
        onPressed: _onTapHandler,
      ),
    );
  }
}
