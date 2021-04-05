import 'package:cloud_firestore/cloud_firestore.dart';

class Todo {
  String id = "";
  String title = "";
  String description = "";
  DateTime createdTime = DateTime.now().toUtc();
  bool isDone = false;

  Todo({
    required this.title,
    required this.description,
    required this.createdTime,
    this.isDone = false,
    id,
  });

  // Json -> Todo
  static Todo fromJson(Map<String, dynamic> json) => Todo(
        title: json['title'],
        description: json['description'],
        createdTime: toDateTime(json['createdTime']),
        id: json['id'],
        isDone: json['isDone'],
      );

  // Todo -> Json
  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        'createdTime': createdTime,
        'isDone': isDone,
        'id': id,
      };

  static DateTime toDateTime(Timestamp value) {
    return value.toDate();
  }
}
