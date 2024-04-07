import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterdatabase/database/hive_task_repo.dart';
import 'package:flutterdatabase/models/todo_model.dart';

class TaskNotifier extends StateNotifier<List<Todo>> {
  TaskNotifier() : super([]) {
    fetchTodos();
  }

  final HiveRepository hiveDatabase = HiveRepository();
  Future<void> fetchTodos() async {
    state = await hiveDatabase.getTodos();
  }

  void addTodo(Todo todo) async {
    await hiveDatabase.addTodo(todo);
    fetchTodos();
  }

  void putTodo(Todo todo, int key) async {
    await hiveDatabase.putTodo(todo, key);
    fetchTodos();
  }

  void deleteTodo(int index) async {
    await hiveDatabase.deleteTodo(index);
    fetchTodos();
  }

  void updateTodo(Todo todo, int index) async {
    await hiveDatabase.updateTodo(todo, index);
    fetchTodos();
  }

  void clearDatabase() async {
    await hiveDatabase.clearDatabase();
  }
}

final todosDataProvider =
    StateNotifierProvider<TaskNotifier, List<Todo>>((ref) => TaskNotifier());
