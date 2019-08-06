class Task {
  Task(
      {this.id,
      this.name,
      this.notes,
      this.time,
      this.repeatInterval,
      this.weekday,
      this.day,
      this.month,
      this.year});

  int id;
  String name;
  String notes;
  int time;
  int repeatInterval;
  // weedays are stored 1-7, 1 being monday
  int weekday;
  int day;
  String month;
  int year;

  static final columns = [
    "id",
    "name",
    "notes",
    "time",
    "repeatInterval",
    "weekday",
    "day",
    "month",
    "year"
  ];

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "notes": notes,
      "time": time,
      "repeatInterval": repeatInterval,
      "day": weekday,
      "day": day,
      "month": month,
      "year": year,
    };
  }

  static Task fromMap(Map map) {
    return Task(
      id: map["id"],
      name: map["name"],
      notes: map["notes"],
      time: map["time"],
      repeatInterval: map["repeatInterval"],
      weekday: map["weekday"],
      day: map["day"],
      month: map["month"],
      year: map["year"],
    );
  }

  // determines if a task is repeated
  bool isRepeated() {
    return (repeatInterval != null ||
        weekday == null ||
        day == null ||
        month == null ||
        year == null);
  }
}
