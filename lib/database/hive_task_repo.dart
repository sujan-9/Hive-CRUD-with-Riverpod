import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutterdatabase/models/todo_model.dart';
import 'package:flutterdatabase/usecases/todo_repo.dart';

class HiveRepository implements TodoRepository {
  Future<Box> openBox() async {
    return await Hive.openBox('tasks');
  }

  Future<List<int>> keys() async {
    Box box = await openBox();
    return box.keys.cast<int>().toList();
  }

  @override
  Future<List<Todo>> getTodos() async {
    final box = await openBox();
    return box.values.toList().cast<Todo>();
  }

  @override
  Future<void> addTodo(Todo todo) async {
    final box = await openBox();
    await box.add(todo);
    await box.close(); // Close the box to persist changes
  }

  Future<void> putTodo(Todo todo, int key) async {
    final box = await openBox();
    await box.put(key, todo);
    await box.close(); // Close the box to persist changes
  }

  @override
  Future<void> deleteTodo(int index) async {
    final box = await openBox();
    //await box.deleteAt(index);
    await box.deleteAt(index);
    await box.close(); // Close the box to persist changes
  }

  @override
  Future<void> updateTodo(Todo updatedTodo, int index) async {
    final box = await openBox();

    //await box.put(index, updatedTodo);
    await box.putAt(index, updatedTodo);

    await box.close(); // Close the box to persist changes
  }

  @override
  Future<void> clearDatabase() async {
    final box = await openBox();

    await box.clear();
    await box.close();
  }
}
