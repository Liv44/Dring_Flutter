import 'dart:convert';
import 'dart:math';
import 'package:dring/history.dart';
import 'package:dring/utils.dart';
import 'package:dring/widgets/dayHistoryWidget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class HistoryButtonWidget extends StatefulWidget {
  const HistoryButtonWidget({super.key});

  @override
  State<HistoryButtonWidget> createState() => _HistoryButtonWidgetState();
}

class _HistoryButtonWidgetState extends State<HistoryButtonWidget> {
  History history = History(0, 0, []);

  @override
  void initState() {
    getHistory();
    super.initState();
  }

  getHistory() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    
    String string = sharedPreferences.getString('history')!;
    Map<String, dynamic> json = await jsonDecode(string);
    History fromJson = History.fromJson(json);

    setState(() {
      history = fromJson;
    });
  }

  List<DayHistoryWidget> getSession(List<Session> sessions) {
    List<DayHistoryWidget> widgetList = [];
    for (int i = 0; i < sessions.length; i++) {
      Session session = sessions[i];
      DayHistoryWidget newItem = DayHistoryWidget(
        date: session.date, 
        workTimeInHours: session.workedTimeInHours.round(), 
        numberOfSessions: session.totalOfSessions
      );
      widgetList.add(newItem);
    }
    return widgetList;
  } 
  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60, 
      margin: const EdgeInsets.all(7), 

      decoration: const BoxDecoration(
        color: Colors.transparent, 
        borderRadius: BorderRadius.all(Radius.circular(100))
      ),

      child: IconButton(
        icon : Icon(Icons.book, size: 40, color: Colors.green[500]),
        
        onPressed: () {
          getHistory();
          showDialog(
            context: context, 
            
            builder: (context) => AlertDialog(
              title: Text('History', style: textStyle(25, Colors.black, FontWeight.w700),),

              contentPadding: const EdgeInsets.all(20),

              content: SingleChildScrollView(
                child : Column(
                  crossAxisAlignment : CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Total number of days worked :  ${history.totalTimeWorkedInDays.round()} days",
                      style: textStyle(15, Colors.black, FontWeight.w200),
                    ),
                    newSeparator(15),
                    Text(
                      "Total number of sessions : ${history.totalNumberOfSessions} sessions",
                      style: textStyle(15, Colors.black, FontWeight.w200),
                    ),
                    newSeparator(15),

                    Column(
                     children: getSession(history.sessions),
                    ),
                  ],
                ),
              ),

              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },

                  child: const Text('Close'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}