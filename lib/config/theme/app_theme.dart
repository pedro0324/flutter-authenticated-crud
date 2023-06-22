import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const primario = Color(0xFF003b5c);
const secundario = Color(0xFF00b5e2);

const scaffoldBackgroundColor = Colors.white;

class AppTheme {
  ThemeData getTheme() => ThemeData(

      ///* General
      useMaterial3: true,
      colorSchemeSeed: primario,

      ///* Texts
      textTheme: TextTheme(
          titleLarge: GoogleFonts.sourceSansPro()
              .copyWith(fontSize: 50, fontWeight: FontWeight.bold,color: primario),
          titleMedium: GoogleFonts.sourceSansPro()
              .copyWith(fontSize: 30, fontWeight: FontWeight.bold),
          titleSmall: GoogleFonts.sourceSansPro().copyWith(fontSize: 20)),

      ///* Scaffold Background Color
      scaffoldBackgroundColor: scaffoldBackgroundColor,

      ///* Buttons
      filledButtonTheme: FilledButtonThemeData(
          style: ButtonStyle(
              textStyle: MaterialStatePropertyAll(GoogleFonts.sourceSansPro()
                  .copyWith(fontWeight: FontWeight.w700)))),

      ///* AppBar
      appBarTheme: AppBarTheme(
        color: scaffoldBackgroundColor,
        titleTextStyle: GoogleFonts.sourceSansPro().copyWith(
            fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black),
      ));
}
