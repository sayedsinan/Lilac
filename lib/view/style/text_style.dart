import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


TextStyle jostTextStyle({
  double fontSize = 16,
  Color color = Colors.black,
  FontWeight fontWeight = FontWeight.normal,
}) {
  return GoogleFonts.jost(
    fontSize: fontSize,
    color: color,
    fontWeight: fontWeight,
  );
}


TextStyle poppinsTextStyle({
  double fontSize = 16,
  Color color = Colors.black,
  FontWeight fontWeight = FontWeight.normal,
}) {
  return GoogleFonts.poppins(
    fontSize: fontSize,
    color: color,
    fontWeight: fontWeight,
  );
}
