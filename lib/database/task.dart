import 'package:flutter/material.dart';

class Task {
  Task({
    this.id,
    @required this.name,
    @required this.notes,
    @required this.date,
    @required this.startTime,
    @required this.endTime,
    this.status = Status.incomplete,
  });

  int id;
  String name;
  String notes;
  // date is in milliseconds since epoch
  int date;
  // time is in milliseconds since epoch
  int startTime;
  int endTime;
  Status status;

  static final columns = [
    "id",
    "name",
    "notes",
    "date",
    "startTime",
    "endTime",
    "status",
  ];

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "notes": notes,
      "date": date,
      "startTime": startTime,
      "endTime": endTime,
      "status": status.index,
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
      status: Status.values[map["status"]],
    );
  }
}

enum Status { incomplete, complete, moved, canceled }
