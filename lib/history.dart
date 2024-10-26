
import 'dart:collection';

class History {
  double totalTimeWorkedInDays = 0;
  int totalNumberOfSessions = 0;
  List<Session> sessions = [];

  History(this.totalTimeWorkedInDays, this.totalNumberOfSessions, this.sessions);

  Map<String, dynamic> sessionToJson() {
    Map<String, dynamic> sessionsJson = <String, dynamic>{};
    for (var session in sessions) {
      var sessionJson = <String, dynamic>{
        'date': session.date,
        'workedTimeInHours': session.workedTimeInHours,
        'totalOfSessions': session.totalOfSessions
      };

      sessionsJson.addEntries(sessionJson.entries);
    }
    return sessionsJson;
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> result = HashMap();
    List listOfSessions = [];
    sessions.forEach((session) {
      listOfSessions.add(session.toJson());
    });
    result.addAll({
      'totalTimeWorkedInDays': totalTimeWorkedInDays,
      'totalNumberOfSessions': totalNumberOfSessions,
      'sessions': listOfSessions
    });
    return result;
  }

  factory History.fromJson(Map<String, dynamic> json) {
    History newHistory =  History(0, 0, []);

    // print("################################## 1 ${json['totalTimeWorkedInDays']}");
    // print("################################## 2 ${json['totalNumberOfSessions']}");
    // newHistory.totalTimeWorkedInDays = json['totalTimeWorkedInDays'];
    // newHistory.totalNumberOfSessions = json['totalNumberOfSessions'];

    // List<Session> sessionList = json['sessions'];
    newHistory.sessions = [];

    return newHistory;
  }
}

class Session {
  DateTime date = DateTime.now();
  double workedTimeInHours = 0;
  int totalOfSessions = 0;

  Session(this.date, this.workedTimeInHours, this.totalOfSessions);

  String dateToJson() {
    return "${date.day},${date.month},${date.year}";
  }

  DateTime jsonToDate(String string) {
    List list = string.split(',');
    DateTime result = DateTime(list[2], list[1], list[0]);
    return result;
  }

  Map<String, dynamic> toJson() => {
    'date': dateToJson(),
    'workedTimeInHours': workedTimeInHours,
    'totalOfSessions': totalOfSessions
  };
}