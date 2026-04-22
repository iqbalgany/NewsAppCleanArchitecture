import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.white,
    textTheme: GoogleFonts.mulishTextTheme(),
    appBarTheme: appBarTheme(),
  );
}

AppBarThemeData appBarTheme() {
  return AppBarThemeData(
    backgroundColor: Colors.white,
    surfaceTintColor: Colors.white,
    elevation: 0,
    centerTitle: true,
    iconTheme: IconThemeData(color: Color(0xff8b8b8b)),
    titleTextStyle: TextStyle(color: Color(0xff8b8b8b), fontSize: 18),
  );
}
