import 'package:dring/timerService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils.dart';

class TimeSelectionWidget extends StatefulWidget {
  const TimeSelectionWidget({
    super.key,
    this.focusDuration = 25,
    this.pauseDuration = 5,
    this.isInUse = false,
  });
  final double focusDuration;
  final double pauseDuration;
  final bool isInUse;

  @override
  State<TimeSelectionWidget> createState() => _TimeSelectionWidgetState();
}

class _TimeSelectionWidgetState extends State<TimeSelectionWidget> {  
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TimerService>(context);
    return Container(
      width: 100, height: 40, 
      padding: const EdgeInsets.all(0),
      margin: const EdgeInsets.all(0),
      decoration: const BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.all(Radius.circular(1))
      ),
      child: TextButton(
        style: ButtonStyle(
          overlayColor: WidgetStatePropertyAll(Colors.green[100]),
        ),
        child : Text(
          style: textStyle(18, widget.isInUse == true ? Colors.green[600] : Colors.green[200] , FontWeight.w500),
          "${widget.focusDuration.round()} | ${widget.pauseDuration.round()}",
        ),
        onPressed: () {
          provider.changeTimesDuration(widget.focusDuration, widget.pauseDuration, widget.focusDuration);
          provider.resetTimer();
          // provider widget.isInUse = !widget.isInUse;
        },
      ),
    );
  }
}