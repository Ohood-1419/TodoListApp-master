// To parse this JSON data, do
//
//     final student = studentFromJson(jsonString);

import 'dart:convert';

Note notesFromJson(String str) => Note.fromJson(json.decode(str));

String notesToJson(Note data) => json.encode(data.toJson());

class Note {
  Note({
    this.id,
    required this.task,
  });

  String? id;

  final String task;

  factory Note.fromJson(Map<String, dynamic> json) => Note(
        id: json["id"],
        task: json["task"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "task": task,
      };
}
