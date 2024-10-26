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
    setState(() {
      String string = sharedPreferences.getString('history')!;
      Map<String, dynamic> json = jsonDecode(string);
      history = History.fromJson(json);
    });
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
                      "Total number of days worked : 27 days",
                      style: textStyle(15, Colors.black, FontWeight.w200),
                    ),
                    newSeparator(15),
                    Text(
                      "Total number of sessions : 718 sessions",
                      style: textStyle(15, Colors.black, FontWeight.w200),
                    ),
                    newSeparator(15),

                    Text("sessions : ${history.totalNumberOfSessions} time ${history.totalTimeWorkedInDays}"),
                    newSeparator(15),

                    DayHistoryWidget(date: DateTime.now(), workTimeInHours: Random().nextInt(25), numberOfSessions: Random().nextInt(100)),
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