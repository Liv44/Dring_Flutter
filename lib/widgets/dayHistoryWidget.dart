import 'package:dring/utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class DayHistoryWidget extends StatefulWidget {
  const DayHistoryWidget({
    super.key,
    required this.date,
    required this.workTimeInHours,
    required this.numberOfSessions,
  });

  final DateTime date;
  final double workTimeInHours;
  final int numberOfSessions;

  @override
  State<DayHistoryWidget> createState() => _DayhistorywidgetState();
}

class _DayhistorywidgetState extends State<DayHistoryWidget> {
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        DateFormat('EEE. d MMM yyyy').format(widget.date),
        style: textStyle(16, Colors.black ,FontWeight.w700),
      ),
      expandedCrossAxisAlignment : CrossAxisAlignment.start,
      minTileHeight: 10,
      tilePadding: const EdgeInsets.all(1),
      childrenPadding: const EdgeInsets.only(left: 42, top: 5, bottom: 5),
      expandedAlignment: Alignment.centerLeft,
      controlAffinity: ListTileControlAffinity.leading,
      iconColor: Colors.black,
      children: [
          Text(
            "Total work time : ${widget.workTimeInHours.round()} hours",
            style: textStyle(13, Colors.black ,FontWeight.w200),
          ),
          newSeparator(10),
          Text(
            "Total sessions : ${widget.numberOfSessions} sessions",
            style: textStyle(13, Colors.black ,FontWeight.w200),
          ),
      ],
    );
  }
}