import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterdatabase/controller/completed_list_provider.dart';

class FavScreen extends ConsumerStatefulWidget {
  const FavScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FavScreenState();
}

class _FavScreenState extends ConsumerState<FavScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetch();
  }

  void fetch() async {
    await ref.read(favListProvider.notifier).fetch();
  }

  @override
  Widget build(BuildContext context) {
    final completedList = ref.watch(favListProvider);
    return Scaffold(
        backgroundColor: Colors.grey.withOpacity(0.9),
        appBar: AppBar(
          title: const Text('Fav Page'),
          centerTitle: true,
        ),
        body: completedList.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.all(12.0),
                child: ListView.builder(
                    itemCount: completedList.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          title: Text(
                            completedList[index].title,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                          subtitle: Text(
                            completedList[index].desc,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w400),
                          ),
                          trailing: IconButton(
                              onPressed: () {
                                ref
                                    .read(favListProvider.notifier)
                                    .delete(index);
                              },
                              icon: const Icon(Icons.delete_forever_rounded)),
                        ),
                      );
                    }),
              )
            : const Center(child: Text('no data')));
  }
}
