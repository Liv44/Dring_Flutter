import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle textStyle(double size, Color? color, FontWeight fw){
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

double secondsToMinutes(double timeInSeconds) {
  return timeInSeconds / 60;
}

double minToHours(double timeInMinutes) {
  return timeInMinutes / 60;
}

double hoursToDays(double timeInHours) {
  return timeInHours / 24;
}

double minToDays(double timeInMinutes) {
  return hoursToDays(minToHours(timeInMinutes));
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