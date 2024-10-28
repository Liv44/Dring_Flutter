import 'dart:convert';
import 'dart:math';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:dring/history.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'utils.dart';

class TimerService extends ChangeNotifier{
  Timer? timer;
  double durationOfFocus = minToSeconds(.1);
  double durationOfBreak = minToSeconds(.05);
  double durationOfLongBreak = minToSeconds(.1);
  double timeLeft = minToSeconds(.1);
  int round = 0;
  bool isPlaying = false;
  AppStatus appStatus = AppStatus.stopped;
  AppStatus previousAppStatus = AppStatus.stopped;
  var statusStrings = ["Focus Time", "Break Time", "Long Break Time", "Stopped"];
  String statusString = "Stopped";
  var colorsOfProgressWidgets = [Colors.green[300], Colors.green[300], Colors.green[300], Colors.green[300]];
  var inUseProgressWidgets = [false, false, false, false];
  var isFilledProgressWidgets = [false, false, false, false];

  SharedPreferences? sharedPreferences;



  void changeTimesDuration(double focusDuration, double breakDuration, double longBreakDirection)
  {
    durationOfFocus = minToSeconds(focusDuration);
    durationOfBreak = minToSeconds(breakDuration);
    durationOfLongBreak = minToSeconds(longBreakDirection);
    notifyListeners();
  }

  void setTimerTime(double timeToSet)
  {
    timeLeft = timeToSet;
    notifyListeners();
  }

  void startTimer()
  {
    if (round == 0) {
      round++;
      setAppStatus(AppStatus.focus);
    } else {
      setAppStatus(previousAppStatus);
    }
    isPlaying = true;
    setProgressInUseAndColors();
    notifyListeners();
    timer = Timer.periodic(
      const Duration(seconds: 1), 
      (timer) {
        timeLeft--;
        if (timeLeft < 0) {
          timerEnded();
        }
        setProgressInUseAndColors();
        notifyListeners();
      },
    );
  }

  void stopTimer()
  {
    isPlaying = false;
    timer?.cancel();
    setAppStatus(AppStatus.stopped);
    notifyListeners();
  }

  void timerEnded()
  {
    setHistory();
    round++;
    if (appStatus == AppStatus.focus) {
      if (round >= 8) { 
        triggerNotification("Dring ! Timer is up !", "You did 4 focus time in a row, it's time for a long break !");
        setAppStatus(AppStatus.longBreak);
        setTimerTime(durationOfLongBreak);
        return;
      } else {
        triggerNotification("Dring ! Timer is up !", "Focus time is over, time for a short break !");
        setAppStatus(AppStatus.shortBreak);
        setTimerTime(durationOfBreak);
      }
      timeLeft++; //Otherwise the first second of the break time is cut
    } else if (appStatus == AppStatus.shortBreak || appStatus == AppStatus.longBreak) {
      if (appStatus == AppStatus.longBreak) {
        round = 1;
      }
      triggerNotification("Dring ! Timer is up !", "Break is over, time to focus up !");
      setAppStatus(AppStatus.focus);
      setTimerTime(durationOfFocus);
    }
    setProgressInUseAndColors();
    notifyListeners();
  }

  void resetTimer()
  {
    stopTimer();
    round = 0;
    setAppStatus(AppStatus.stopped);
    setTimerTime(durationOfFocus);
    setProgressInUseAndColors();
    notifyListeners();
  }

  void setAppStatus(AppStatus newAppStatus){
    previousAppStatus = appStatus;
    appStatus = newAppStatus;
    switch (newAppStatus) {
      case AppStatus.focus:
        statusString = statusStrings[0];
        break;
      case AppStatus.shortBreak:
        statusString = statusStrings[1];
        break;
      case AppStatus.longBreak:
        statusString = statusStrings[2];
        break;
      case AppStatus.stopped:
        statusString = statusStrings[3];
        break;
    }

    notifyListeners();
  }

  void setProgressInUseAndColors()
  {
    inUseProgressWidgets = [false, false, false, false];
    switch (round) {
      case 0:
        isFilledProgressWidgets = [false, false, false, false];
        colorsOfProgressWidgets = [Colors.green[300], Colors.green[300], Colors.green[300], Colors.green[300]];
        break;
      case 1:
        isFilledProgressWidgets = [false, false, false, false];
        colorsOfProgressWidgets = [Colors.green[300], Colors.green[300], Colors.green[300], Colors.green[300]];
        inUseProgressWidgets[0] = true;
        break;
      case 2:
        isFilledProgressWidgets[0] = true;
        colorsOfProgressWidgets[0] = Colors.blue[300];
      case 3: 
        inUseProgressWidgets[1] = true;
        break;
      case 4:
        isFilledProgressWidgets[1] = true;
        colorsOfProgressWidgets[1] = Colors.blue[300];
        break;
      case 5:
        inUseProgressWidgets[2] = true;
        break;
      case 6:
        isFilledProgressWidgets[2] = true;
        colorsOfProgressWidgets[2] = Colors.blue[300];
        break;
      case 7:
        inUseProgressWidgets[3] = true;
        break;
      case 8:
        isFilledProgressWidgets[3] = true;
        colorsOfProgressWidgets = [Colors.purple[300], Colors.purple[300], Colors.purple[300], Colors.purple[300]];
        break;
    }
  }

  void triggerNotification(String tilte, String body) 
  {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 10,
        channelKey: 'basic_channel',
        title: tilte,
        body: body,
      ),
    );
  }

  Future<History> getHistory() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    
    String string = sharedPreferences.getString('history')!;
    Map<String, dynamic> json = await jsonDecode(string);
    History history = History.fromJson(json);

    return history;
  }

  setHistory() async {
    History history = await getHistory();

    // // Session newSession = Session(DateTime.now(), Random().nextDouble() * 2, Random().nextInt(6));
    // Session newSession = Session(DateTime.now(), 1, 10);
    // List<Session> newSessions = [newSession];

    // // History newHistory = History(Random().nextDouble() * 72, Random().nextInt(100), newSessions);
    // History newHistory = History(1 / 24, 10, newSessions);
    if(history != null) {
      history.totalNumberOfSessions += 1;
      if (appStatus == AppStatus.shortBreak) {
        history.totalTimeWorkedInDays += durationOfBreak / 24;
      } else {
        history.totalTimeWorkedInDays += durationOfFocus / 24;
      }

      for (var session in history.sessions) {
        if (isSameDay(session.date, DateTime.now())) {
          session.totalOfSessions += 1;
          session.workedTimeInHours += durationOfFocus / 60;
          break;
        }
        Session newSession = Session(DateTime.now(), durationOfFocus / 60, 1 );
        history.sessions.add(newSession);
      }
    } else {
      Session newSession = Session(DateTime.now(), durationOfFocus / 60, 1 );
      history = History((durationOfFocus / 60) / 24, 1, [newSession]);
    }

    Map<String, dynamic> jsonMap = history.toJson();
    String json = jsonEncode(jsonMap);

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('history', json);
  }

  static bool isSameDay(DateTime? dateA, DateTime? dateB) {
  return
    dateA?.year == dateB?.year &&
    dateA?.month == dateB?.month &&
    dateA?.day == dateB?.day;
  }

  
}
