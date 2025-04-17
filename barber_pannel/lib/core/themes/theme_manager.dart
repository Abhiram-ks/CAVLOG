import 'package:barber_pannel/core/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    primaryColor: AppPalette.blueClr,
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppPalette.scafoldClr,
    fontFamily: GoogleFonts.roboto().fontFamily,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
     backgroundColor: AppPalette.whiteClr,
      selectedItemColor: AppPalette.blackClr,
      unselectedItemColor: const Color.fromARGB(255, 86, 86, 86),
    ),
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