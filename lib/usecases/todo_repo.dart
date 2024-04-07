import 'package:flutterdatabase/models/todo_model.dart';

abstract class TodoRepository {
  Future<List<Todo>> getTodos();
  Future<void> addTodo(Todo todo);
  Future<void> updateTodo(Todo todo, int index);
  Future<void> deleteTodo(int index);
  Future<void> clearDatabase();
}
