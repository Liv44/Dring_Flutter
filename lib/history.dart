
class History {
  double totalTimeWorkedInDays = 0;
  int totalNumberOfSessions = 0;
  List<Session> sessions = [];

}

class Session {
  DateTime date = DateTime.now();
  double workedTimeInHours = 0;
  int totalOfSessions = 0;
}