import 'package:flutter/material.dart';

class ProgressWidget extends StatefulWidget {
  const ProgressWidget({
    super.key,
    this.progression = 0,
    this.divisions = 5,
    this.emptyColor = Colors.grey,
    this.filledColor = Colors.green,
    this.isInUse = false,
    this.isFilled = false,
  });

  final double progression;
  final double divisions;
  final Color? emptyColor;
  final Color? filledColor;
  final bool isInUse;
  final bool isFilled;

  @override
  State<ProgressWidget> createState() => _ProgressWidgetState();
}

class _ProgressWidgetState extends State<ProgressWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.isInUse ? 30 : 10,
      height: 10,
      margin: const EdgeInsets.all(5),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        child: LinearProgressIndicator(
          color: widget.filledColor,
          backgroundColor: widget.emptyColor,
          value: (widget.isInUse) 
            ? 1 - ((1/ widget.divisions) * widget.progression) 
            : (widget.isFilled) ? 1 : 0
        ),
      ),
    );
  }
}