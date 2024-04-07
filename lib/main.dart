import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterdatabase/models/completed_list.dart';
import 'package:flutterdatabase/models/todo_model.dart';
import 'package:flutterdatabase/screens/hompage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runZonedGuarded(() async {
    await init();
    runApp(const ProviderScope(child: MyApp()));
  }, (error, stackTrace) {
    print('Error occurred: $error');
  });
}

Future<void> init() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    // Initialize Hive
    final appDocumentDirectory = await getApplicationDocumentsDirectory();

    await Hive.initFlutter(appDocumentDirectory.path);
    Hive.registerAdapter(TodoAdapter());
    Hive.registerAdapter(CompletedListAdapter());
    await Hive.openBox('tasks');
    await Hive.openBox('completed');
  } catch (error) {
    print('Error initializing Hive: $error');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(backgroundColor: Colors.grey),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Homepage(),
    );
  }
}
