import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterdatabase/database/completed_task.dart';
import 'package:flutterdatabase/models/completed_list.dart';

class CompletedNotifier extends StateNotifier<List<CompletedList>> {
  CompletedNotifier() : super([]) {
    fetch();
  }

  final HiveCompletedRepository completedTask = HiveCompletedRepository();

  void addToFav(CompletedList fav) async {
    await completedTask.addTodo(fav);
    fetch();
  }

  Future<void> fetch() async {
    state = await completedTask.getTodos();
  }

  Future<void> delete(int index) async {
    await completedTask.deleteTodo(index);
    fetch();
  }
}

final favListProvider =
    StateNotifierProvider<CompletedNotifier, List<CompletedList>>((ref) {
  return CompletedNotifier();
});
