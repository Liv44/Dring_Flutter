import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle textStyle(double size, [Color? color, FontWeight? fw]){
  return GoogleFonts.poppins(
    fontSize: size,
    color: color,
    fontWeight: fw,
  );
}

double minToSeconds(double timeInMinutes)
{
  return timeInMinutes * 60;
}

Widget newSeparator(double size)
{
  return SizedBox(height: size, width: size);
}

enum AppStatus {
  focus,
  shortBreak,
  longBreak,
  stopped,
}