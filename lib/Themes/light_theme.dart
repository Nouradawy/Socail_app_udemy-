import 'package:flutter/material.dart';

ThemeData LightThemeData() {
  return ThemeData(
    fontFamily: 'jannah',
    primarySwatch: Colors.blue,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.blue,
    ),
    textTheme: TextTheme(
      bodyText1:TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color:Colors.white,
      ),
      subtitle1: TextStyle(
        fontSize:16,
        fontWeight: FontWeight.w600,
        color:Colors.black,
      ),
    ),
  );
}