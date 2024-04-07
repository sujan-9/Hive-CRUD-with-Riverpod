// ignore_for_file: public_member_api_docs, sort_constructors_first
// class Todo {
//   // final String id;
//   final String title;
//   final String description;
//   // final DateTime deadline;
// //  bool isCompleted;

//   Todo({
//     // required this.id,
//     required this.title,
//     required this.description,
//     //  required this.deadline,
//     //  this.isCompleted = false,
//   });
// }

import 'package:hive/hive.dart';

part 'todo_model.g.dart'; // Generated file will have this name

@HiveType(typeId: 0)
class Todo {
  @HiveField(0)
  int id;
  @HiveField(1)
  final String title;

  @HiveField(2)
  final String description;

  Todo({required this.title, required this.description, this.id = 0});
}
