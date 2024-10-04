import 'package:flutter/material.dart';

class AppFonts{

  static TextStyle heading({required Color color}) {
    return TextStyle(
      fontFamily: 'Raglika',
      fontSize: 22,
      fontWeight: FontWeight.bold,
      color: color,
    );
  }
  static TextStyle body({required Color color}) {
    return TextStyle(
      fontFamily: 'Helvetica',
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: color,
    );
  }
}