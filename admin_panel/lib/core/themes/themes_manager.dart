import 'package:admin/core/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    primaryColor: AppPalette.blueClr,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppPalette.whiteClr,
    fontFamily: GoogleFonts.roboto().fontFamily,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppPalette.blueClr,
       iconTheme: IconThemeData(color: Colors.black),
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: AppPalette.blackClr),
      bodyMedium: TextStyle(color: AppPalette.blackClr),
      bodySmall: TextStyle(color: AppPalette.blackClr),
    )
  );
}