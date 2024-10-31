import 'package:dring/utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DayHistoryWidget extends StatefulWidget {
  const DayHistoryWidget({
    super.key,
    required this.date,
    required this.workTimeInSeconds,
    required this.numberOfSessions,
  });

  final DateTime date;
  final double workTimeInSeconds;
  final int numberOfSessions;

  @override
  State<DayHistoryWidget> createState() => _DayhistorywidgetState();
}

// This code belongs to Mathéo LEGER @matheoleger
String getFormattedTimeForHistory(double time) {
  const int oneHour = 3600000; // 1 heure = 3600 * 1000 ms
  const int oneMinute = 60000; // 1 minute = 60 * 1000 ms
  const int oneSecond = 1000; // 1 seconde = 1000 ms
  var remainingMs = time * 1000;

  var hours = (remainingMs / oneHour).floor(); // Give remaining hours
  remainingMs -= hours * oneHour; // Subtract hours
  var minutes = (remainingMs / oneMinute).floor(); // Give remaining minutes
  remainingMs -= minutes * oneMinute; // Subtract minutes
  var seconds = (remainingMs / oneSecond).floor(); // Give remaining seconds

  var formattedHours = hours < 10 ? "0$hours" : "$hours";
  var formattedMinutes = minutes < 10 ? "0$minutes" : "$minutes";
  var formattedSeconds = seconds < 10 ? "0$seconds" : "$seconds";

  return "$formattedHours:$formattedMinutes:$formattedSeconds";
}

class _DayhistorywidgetState extends State<DayHistoryWidget> {
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        DateFormat('EEE. d MMM yyyy').format(widget.date),
        style: textStyle(16, Colors.black, FontWeight.w700),
      ),
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      minTileHeight: 10,
      tilePadding: const EdgeInsets.all(1),
      childrenPadding: const EdgeInsets.only(left: 42, top: 5, bottom: 5),
      expandedAlignment: Alignment.centerLeft,
      controlAffinity: ListTileControlAffinity.leading,
      iconColor: Colors.black,
      children: [
        Text(
          "Total work time : ${getFormattedTimeForHistory(widget.workTimeInSeconds)}",
          style: textStyle(13, Colors.black, FontWeight.w200),
        ),
        newSeparator(10),
        Text(
          "Total sessions : ${widget.numberOfSessions} sessions",
          style: textStyle(13, Colors.black, FontWeight.w200),
        ),
      ],
    );
  }
}
