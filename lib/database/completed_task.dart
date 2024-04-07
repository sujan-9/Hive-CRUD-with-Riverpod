import 'package:flutterdatabase/models/completed_list.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveCompletedRepository {
  Future<Box> openBox() async {
    return await Hive.openBox('completed');
  }

  Future<List<int>> keys() async {
    Box box = await openBox();
    return box.keys.cast<int>().toList();
  }

  Future<List<CompletedList>> getTodos() async {
    final box = await openBox();
    return box.values.toList().cast<CompletedList>();
  }

  Future<void> addTodo(CompletedList todo) async {
    final box = await openBox();
    await box.add(todo);
    await box.close(); // Close the box to persist changes
  }

  Future<void> deleteTodo(int index) async {
    final box = await openBox();
    //await box.deleteAt(index);
    await box.deleteAt(index);
    await box.close(); // Close the box to persist changes
  }
}
