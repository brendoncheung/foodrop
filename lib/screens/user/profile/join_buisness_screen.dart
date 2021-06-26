import 'package:flutter/material.dart';
import 'package:foodrop/core/models/UserProfile.dart';
import 'package:foodrop/core/models/business.dart';
import 'package:foodrop/core/services/database/database.dart';

class JoinBusinessScreen extends StatefulWidget {
  Database db;
  UserProfile userProfile;
  JoinBusinessScreen({this.db, this.userProfile});

  @override
  _JoinBusinessScreenState createState() => _JoinBusinessScreenState();
}

class _JoinBusinessScreenState extends State<JoinBusinessScreen> {
  TextEditingController _tecSearchField = TextEditingController();
  TextEditingController _tecMessage = TextEditingController();
  bool hasBusinessId = false;
  bool _hasSubmitted = false;

  Widget _buildBusinessStreamBuilder(BuildContext context) {
    try {
      return StreamBuilder<Business>(
          stream: widget.db.businessStream(businessUid: _tecSearchField.text),
          builder: (context, business) {
            switch (business.connectionState) {
              case ConnectionState.waiting:
                {
                  return Text("LOADING");
                }
                break;
              case ConnectionState.active:
                if (business.hasData) {
                  return _buildShowResult(context, business);
                } else {
                  return Column(
                    children: [
                      Placeholder(),
                      SizedBox(height: 16.0),
                      Text(
                        "No results",
                        style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
                      )
                    ],
                  );
                }
                break;
              default:
                {
                  return Text("LOADING");
                }
                break;
            }
          });
    } catch (e) {
      return Text("no result");
    }
  }

  Widget _buildShowResult(
    BuildContext context,
    AsyncSnapshot<Business> business,
  ) {
    final _businessData = business.data;
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      SizedBox(
        height: 8,
      ),
      Image.asset("assets/images/restaurants/restaurant0.jpg"),
      //TODO: load from photoURL
      ListTile(
        leading: Icon(Icons.business),
        title: Text("${_businessData.tradingName} ${_businessData.chineseName}", style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
      ),
      ListTile(
        leading: Icon(Icons.home),
        title: Text("${_businessData.streetAddress}\n${_businessData.suburb}\n${_businessData.city}", style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
      ),
      SizedBox(
        height: 24,
      ),
      ElevatedButton(
          onPressed: () => _getAdditionalInfo(context, _businessData),
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Text(
              "I work here",
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
          ))
    ]);
  }

  Widget _buildSearchField() {
    return TextField(
      controller: _tecSearchField,
      onEditingComplete: _submit,
      decoration: InputDecoration(
          errorText: !_tecSearchField.text.isNotEmpty && _hasSubmitted ? "cannot be empty" : null,
          contentPadding: EdgeInsets.symmetric(vertical: 15.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide(width: 0.8),
          ),
          hintText: "type '1112223' to test ", //Enter companies office number // TODO: correct the hint text
          prefixIcon: Icon(
            Icons.search,
            size: 30,
          ),
          suffixIcon: IconButton(
            icon: Icon(Icons.clear),
            onPressed: () => _tecSearchField.text = "",
          )),
    );
  }

  void _submit() {
    // check search field is not empty
    if (_tecSearchField.text.isNotEmpty) {
      setState(() {
        _hasSubmitted = true;
        hasBusinessId = true;
      });
    } else {
      setState(() {
        hasBusinessId = false;
      });
    }

    // perform search if has business id
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Join a business"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(32.0),
          child: Column(
            children: [
              _buildSearchField(),
              SizedBox(
                height: 16,
              ),
              hasBusinessId ? _buildBusinessStreamBuilder(context) : Text(""),
            ],
          ),
        ),
      ),
    );
  }

  void _getAdditionalInfo(BuildContext context, Business business) async {
    _tecMessage.text = "I am ${widget.userProfile.username} ";
    var didRequestForSubmit = await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Send Approal"),
              content: TextField(
                controller: _tecMessage,
                maxLines: 5,
                decoration: InputDecoration(
                  labelText: "Write a message..",
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text("Submit"),
                ),
                TextButton(onPressed: () => Navigator.of(context).pop(false), child: Text("Cancel"))
              ],
            ));

    if (didRequestForSubmit) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Hi ${widget.userProfile.username}\nRequest Submitted!\nPlease wait for notification",
            style: TextStyle(fontSize: 24),
          ),
        ),
      );
    }
    // Future.delayed(Duration(seconds: 4))
    //     .then((_) => Navigator.of(context).pop());
  }
}
