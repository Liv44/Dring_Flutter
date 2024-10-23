import 'package:dring/utils.dart';
import 'package:flutter/material.dart';

class DayHistoryWidget extends StatefulWidget {
  const DayHistoryWidget({
    super.key,
    required this.date,
    required this.workTimeInHours,
    required this.numberOfSessions,
  });

  final DateTime date;
  final int workTimeInHours;
  final int numberOfSessions;

  @override
  State<DayHistoryWidget> createState() => _DayhistorywidgetState();
}

class _DayhistorywidgetState extends State<DayHistoryWidget> {
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        widget.date.toString(),
        style: textStyle(16, Colors.black ,FontWeight.w500),
      ),
      expandedCrossAxisAlignment : CrossAxisAlignment.start,
      children: [
          Text(
            "Total work time : ${widget.workTimeInHours} hours",
            style: textStyle(13, Colors.black ,FontWeight.w200),
          ),
          Text(
            "Total sessions : ${widget.numberOfSessions} sessions",
            style: textStyle(13, Colors.black ,FontWeight.w200),
          ),
      ],
    );
  }
}