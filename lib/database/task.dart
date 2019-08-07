class Task {
  Task({
    this.id,
    this.name,
    this.notes,
    this.date,
    this.startTime,
    this.endTime,
  });

  int id;
  String name;
  String notes;
  // date is in milliseconds since epoch / 86400000
  int date;
  // time is in milliseconds since epoch
  int startTime;
  int endTime;

  static final columns = [
    "id",
    "name",
    "notes",
    "date",
    "startTime",
    "endTime",
  ];

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "notes": notes,
      "date": date,
      "startTime": startTime,
      "endTime": endTime,
    };
  }

  static Task fromMap(Map map) {
    return Task(
      id: map["id"],
      name: map["name"],
      notes: map["notes"],
      date: map["date"],
      startTime: map["startTime"],
      endTime: map["endTime"],
    );
  }
}
