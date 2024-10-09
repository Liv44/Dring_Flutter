import 'dart:async';

import 'package:flutter/material.dart';

class TimerService extends ChangeNotifier{
  Timer? timer;
  double durationOfFocus = 1500;
  double timeLeft = 1500;
  int round = 1500;
  bool isPlaying = false;

  void setDurationOfFocus(double time)
  {
    durationOfFocus = time;
    timeLeft = time;
    notifyListeners();
  }

  void startTimer()
  {
    isPlaying = true;
    timeLeft--;
    notifyListeners();
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      timeLeft--;
      notifyListeners();
    });
  }

  void stopTimer()
  {
    isPlaying = false;
    timer?.cancel();
    notifyListeners();
  }

  void resetTimer()
  {
    stopTimer();
    setDurationOfFocus(1500);
  }
}
