import 'package:flutter/material.dart';

class MyThemes {
  static ThemeData get lightTheme {
    return ThemeData(
      scaffoldBackgroundColor: MyColors.appBackgroundColor,
      primarySwatch: Colors.teal,
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Colors.orange[700],
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          // backgroundColor: MaterialStateProperty.all<Color?>(const Color(0xFF466443)),
          // foregroundColor: MaterialStateProperty.all<Color?>(const Color(0xFFF3FAF2)),
          elevation: MaterialStateProperty.all<double?>(0),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        fillColor: Colors.white,
        // focusColor: Colors.green,
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey[500]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.teal),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData();
  }
}

class MyColors {
  static const Color darkGreen = Color(0xFF466443);
  static const Color textColor = Color(0xFF0A2D31);
  static const Color appBackgroundColor = Color(0xFFF2F2F2);
}
