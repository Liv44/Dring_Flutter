import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'progressWidget.dart';
import '../timerService.dart';

class ProgressDotsWidget extends StatelessWidget {
  const ProgressDotsWidget ({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TimerService>(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ProgressWidget(
          filledColor: provider.colorsOfProgressWidgets[0],
          emptyColor: Colors.green[100],
          divisions: provider.durationOfFocus,
          progression: (provider.timeLeft),
          isInUse: provider.inUseProgressWidgets[0],
          isFilled: provider.isFilledProgressWidgets[0],
        ),
        ProgressWidget(
          filledColor: provider.colorsOfProgressWidgets[1],
          emptyColor: Colors.green[100],
          divisions: provider.durationOfFocus,
          progression: (provider.timeLeft),
          isInUse: provider.inUseProgressWidgets[1],
          isFilled: provider.isFilledProgressWidgets[1],
        ),
        ProgressWidget(
          filledColor: provider.colorsOfProgressWidgets[2],
          emptyColor: Colors.green[100],
          divisions: provider.durationOfFocus,
          progression: (provider.timeLeft),
          isInUse: provider.inUseProgressWidgets[2],
          isFilled: provider.isFilledProgressWidgets[2],
        ),
        ProgressWidget(
          filledColor: provider.colorsOfProgressWidgets[3],
          emptyColor: Colors.green[100],
          divisions: provider.durationOfFocus,
          progression: (provider.timeLeft),
          isInUse: provider.inUseProgressWidgets[3],
          isFilled: provider.isFilledProgressWidgets[3],
        ),
      ],
    );
  }
}