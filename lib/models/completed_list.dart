import 'package:hive_flutter/hive_flutter.dart';
part 'completed_list.g.dart';

@HiveType(typeId: 1)
class CompletedList {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final String desc;

  CompletedList({required this.title, required this.desc});
}
