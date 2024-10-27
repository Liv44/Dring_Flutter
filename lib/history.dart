
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
    List sessionList = json['sessions'];
    List<Session> newSessionList = [];

    sessionList.forEach((session) {
      Map<String, dynamic> sessionTyped = session as Map<String, dynamic>;
      newSessionList.add(Session.fromJson(sessionTyped));
    });

    return History( 
      json['totalTimeWorkedInDays'] as double,
      json['totalNumberOfSessions'] as int,
      newSessionList
    );
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

  static DateTime jsonToDate(String string) {
    List list = string.split(',');
    DateTime result = DateTime(int.parse(list[2]), int.parse(list[1]), int.parse(list[0]));
    return result;
  }

  Map<String, dynamic> toJson() => {
    'date': dateToJson(),
    'workedTimeInHours': workedTimeInHours,
    'totalOfSessions': totalOfSessions
  };

  factory Session.fromJson(Map<String, dynamic> json) {
    DateTime newDate = jsonToDate(json['date']);
    return Session(
      newDate,
      json['workedTimeInHours'] as double ,
      json['totalOfSessions'] as int 
    );
  }
}