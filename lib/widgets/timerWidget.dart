import 'package:dring/timerService.dart';
import 'package:dring/widgets/historyButtonWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils.dart';
import 'progressDotsWidget.dart';
import 'timeSelectionWidget.dart';

class TimerWidget extends StatelessWidget {
  const TimerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TimerService>(context);

    return Column(
      children: [
        Text(
          provider.statusString,
          style: textStyle(14, 
            provider.appStatus == AppStatus.focus ? Colors.green: (provider.appStatus == AppStatus.shortBreak ? Colors.blue : (provider.appStatus == AppStatus.longBreak ? Colors.purple : Colors.black)), 
            FontWeight.w500
          ),
        ),
        newSeparator(5),
        Text(
          "${(provider.timeLeft / 60).floor()}:${(provider.timeLeft % 60).round() < 10 ? "0" : ""}${(provider.timeLeft % 60).round()}",
          style: textStyle(50, Colors.black, FontWeight.w600),
        ),
        newSeparator(5),
        const ProgressDotsWidget(),
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
        const TimeSelectionWidget(),
        const TimeSelectionWidget(focusDuration: 45, pauseDuration: 15),
        const TimeSelectionWidget(focusDuration: .1, pauseDuration: .05),
        newSeparator(5),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
            const HistoryButtonWidget(),
          ],
        ),
      ],
    );
  }
}