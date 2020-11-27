import 'dart:ui';

import 'package:flutter/material.dart';

// change color dynamically based on background color:
// https://stackoverflow.com/questions/56194168/how-to-change-the-text-color-of-the-button-theme-in-flutter

class VendorThemeData {
  static ThemeData get themeData {
    return ThemeData(
      primaryColor: Colors.purple,
      accentColor: Colors.orange,
      textTheme: ThemeData.light().textTheme.copyWith(
            bodyText1: TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1),
            ),
            bodyText2: TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1),
            ),
            headline6: TextStyle(fontSize: 20),
          ),
    );
  }
}
