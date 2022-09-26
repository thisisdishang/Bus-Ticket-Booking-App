
import 'package:flutter/material.dart';

class MyTheme{
  static ThemeData lighttheme(BuildContext context) =>ThemeData(
    appBarTheme: AppBarTheme(
      color: Colors.white,
      elevation: 0.0,
      iconTheme: IconThemeData(color: Colors.black),
      //textTheme: Theme.of(context).textTheme,
    ),
    primaryColor: Colors.blueAccent,
  );

  static ThemeData darktheme(BuildContext context) =>ThemeData(
    brightness: Brightness.dark,
  );
}