import 'package:dring/timerService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils.dart';

class TimerWidget extends StatelessWidget {

  TimerWidget({super.key});
  String statusText = "Focus Time";

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TimerService>(context);

    return Column(
      children: [
        Text(
          statusText, 
          style: textStyle(14, Colors.black, FontWeight.w500),
        ),
        newSeparator(5),
        Text(
          "${(provider.timeLeft / 60).floor()}:${(provider.timeLeft % 60).round()}${(provider.timeLeft % 60).round() == 0 ? "0" : ""}",
          style: textStyle(50, Colors.black, FontWeight.w600),
        ),
        newSeparator(5),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(width: 10,height: 10, margin: const EdgeInsets.all(7), decoration: BoxDecoration(color: Colors.green[100], borderRadius: const BorderRadius.all(Radius.circular(10)))),
            Container(width: 10,height: 10, margin: const EdgeInsets.all(7), decoration: BoxDecoration(color: Colors.green[100], borderRadius: const BorderRadius.all(Radius.circular(10)))),
            Container(width: 10,height: 10, margin: const EdgeInsets.all(7), decoration: BoxDecoration(color: Colors.green[100], borderRadius: const BorderRadius.all(Radius.circular(10)))),
            Container(width: 10,height: 10, margin: const EdgeInsets.all(7), decoration: BoxDecoration(color: Colors.green[100], borderRadius: const BorderRadius.all(Radius.circular(10)))),
          ],
        ),
        Container(width: 60,height: 60, margin: const EdgeInsets.all(7), decoration: BoxDecoration(color: Colors.green[50], borderRadius: const BorderRadius.all(Radius.circular(100))),
          child: IconButton(
            icon : provider.isPlaying 
              ? Icon(Icons.pause, size: 40, color: Colors.green[500]) 
              : Icon(Icons.play_arrow, size: 40, color: Colors.green[500]),
            onPressed: () {
              if (provider.isPlaying) {
                provider.stopTimer();
              } else {
                provider.startTimer();
              }
            },
          ),
        ),
        newSeparator(5),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "25min | 5min", 
              style: textStyle(18, Colors.green[300], FontWeight.w500),
            ),
          ],
        ),
        newSeparator(6),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "45min | 15min", 
              style: textStyle(16, Colors.green[100], FontWeight.w500),
            ),
          ],
        ),
        newSeparator(5),
        Container(width: 60,height: 60, margin: const EdgeInsets.all(7), 
          decoration: const BoxDecoration(
            color: Colors.transparent, 
            borderRadius: BorderRadius.all(Radius.circular(100))
          ),
          child: IconButton(
            icon : Icon(Icons.replay_outlined, size: 40, color: Colors.green[500]),
            onPressed: () {
              provider.resetTimer();
            },
          ),
        ),
      ],
    );
  }
}