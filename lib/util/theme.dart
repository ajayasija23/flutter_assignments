
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final theme= ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: primaryColor, primary: primaryColor, secondary: secondaryColor),
  textTheme: GoogleFonts.robotoTextTheme(), // ✅ Global Google Font
);

//colors

const primaryColor = Color(0xFF0098FF);
const primaryDark = Color(0xFF0098FF);
const secondaryColor = Color(0xFFFFB534);
const secondaryDark = Color(0xFFCE922A);
const lightPrimary = Color(0xFFF0F8EC);