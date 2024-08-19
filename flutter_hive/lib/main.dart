import 'package:flutter/material.dart';
import 'package:flutter_hive/models/notes_model.dart';
import 'package:flutter_hive/screens/home_screen.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  // Ensures Flutter framework is initialized before any async operations.
  WidgetsFlutterBinding.ensureInitialized();

  // Obtains the directory where the app can store files.
  var directory = await getApplicationDocumentsDirectory();

  // Initializes Hive with the path to store data.
  Hive.init(directory.path);

  // Registers a custom adapter for the NotesModel.
  Hive.registerAdapter(NotesModelAdapter());

  // Opens a Hive box to store and retrieve NotesModel data.
  await Hive.openBox<NotesModel>('notes');

  // Runs the main application widget.
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Disables the debug banner in the app.
      debugShowCheckedModeBanner: false,

      // Sets the primary theme color of the app.
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),

      // Sets the HomeScreen widget as the home page of the app.
      home: const HomeScreen(),
    );
  }
}
