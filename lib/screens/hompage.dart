import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterdatabase/controller/task_list_provider.dart';
import 'package:flutterdatabase/controller/completed_list_provider.dart';
import 'package:flutterdatabase/models/completed_list.dart';
import 'package:flutterdatabase/models/todo_model.dart';
import 'package:flutterdatabase/screens/second_screen.dart';

class Homepage extends ConsumerStatefulWidget {
  const Homepage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomepageState();
}

class _HomepageState extends ConsumerState<Homepage> {
  @override
  void initState() {
    super.initState();

    fetch();
  }

  void fetch() async {
    await ref.read(todosDataProvider.notifier).fetchTodos();
  }

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    descController.dispose();
    super.dispose();
  }

  bool isContain = false;
  @override
  Widget build(BuildContext context) {
    final data = ref.watch(todosDataProvider);

    return Scaffold(
        backgroundColor: Colors.grey.withOpacity(0.9),
        appBar: AppBar(
          title: const Text(
            'DataBase example',
          ),
          titleTextStyle: const TextStyle(fontSize: 28, color: Colors.black),
          toolbarHeight: 60,
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  // ref.read(todosDataProvider.notifier).clearDatabase();

                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const FavScreen();
                  }));
                },
                icon: const Icon(Icons.favorite_border_rounded))
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Enter data'),
                    actions: [
                      buildTextfield(
                        controller: titleController,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      buildTextfield(
                        controller: descController,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            if (titleController.text.isNotEmpty &&
                                descController.text.isNotEmpty) {
                              final notifier =
                                  ref.read(todosDataProvider.notifier);
                              notifier.addTodo(
                                Todo(
                                  title: titleController.text.trim(),
                                  description: descController.text.trim(),
                                  id: data.isNotEmpty ? data.last.id + 1 : 0,
                                ),
                              );

                              titleController.clear();
                              descController.clear();
                              Navigator.pop(context);
                            }
                          },
                          child: const Text('Save'))
                    ],
                  );
                });
          },
          child: const Icon(Icons.add),
        ),
        body: data.isNotEmpty
            ? ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final task = data[index];
                  final fav = ref.watch(favListProvider);
                  bool isContained = fav.any((favItem) =>
                      favItem.title == task.title &&
                      favItem.desc == task.description);

                  return Card(
                    margin: const EdgeInsets.all(12),
                    child: ListTile(
                        title: Text(
                          task.title,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                        subtitle: Text(
                          task.description,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                        trailing: SizedBox(
                          width: 150,
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          titleController.text = task.title;
                                          descController.text =
                                              task.description;
                                          return AlertDialog(
                                            title: const Text('Enter data'),
                                            actions: [
                                              buildTextfield(
                                                controller: titleController,
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              buildTextfield(
                                                controller: descController,
                                              ),
                                              const SizedBox(
                                                height: 16,
                                              ),
                                              ElevatedButton(
                                                  onPressed: () {
                                                    ref
                                                        .read(todosDataProvider
                                                            .notifier)
                                                        .updateTodo(
                                                            Todo(
                                                                title:
                                                                    titleController
                                                                        .text
                                                                        .trim(),
                                                                description:
                                                                    descController
                                                                        .text
                                                                        .trim(),
                                                                id: task.id),
                                                            index);
                                                    titleController.clear();
                                                    descController.clear();
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text('Update'))
                                            ],
                                          );
                                        });
                                  },
                                  icon: const Icon(Icons.edit_document)),
                              IconButton(
                                  onPressed: () {
                                    ref
                                        .read(todosDataProvider.notifier)
                                        .deleteTodo(index);
                                  },
                                  icon:
                                      const Icon(Icons.delete_forever_rounded)),
                              Checkbox(
                                  value: isContained,
                                  onChanged: (value) {
                                    if (isContained == false) {
                                      ref
                                          .read(favListProvider.notifier)
                                          .addToFav(CompletedList(
                                              title: task.title,
                                              desc: task.description));
                                    }
                                    //to fo
                                  }),
                            ],
                          ),
                        )),
                  );
                },
              )
            : Center(
                child: TextButton(
                  child: const Text('No data'),
                  onPressed: () {
                    // ref.read(todosDataProvider.notifier).fetchTodos();
                  },
                ),
              ));
  }
}

class buildTextfield extends StatelessWidget {
  const buildTextfield({
    super.key,
    required this.controller,
    this.index,
  });
  final TextEditingController controller;
  final int? index;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: const InputDecoration(
          focusedBorder: OutlineInputBorder(),
          enabledBorder: OutlineInputBorder()),
    );
  }
}
