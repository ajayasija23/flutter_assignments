
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final theme= ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: primaryColor, primary: primaryColor, secondary: secondaryColor),
  textTheme: GoogleFonts.robotoTextTheme(), // ✅ Global Google Font
);

//colors

const primaryColor = Color(0xFFFC542C);
const primaryDark = Colors.indigoAccent;
const green = Color(0xFF08A66E);
const red = Color(0xFFDE4D20);
const secondaryColor = Color(0xFFFCC838);
const secondaryDark = Color(0xFFCE922A);
const lightPrimary = Color(0xFFF0F8EC);