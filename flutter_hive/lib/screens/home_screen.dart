import 'package:flutter/material.dart';
import 'package:flutter_hive/boxes/boxes.dart';
import 'package:flutter_hive/models/notes_model.dart';
import 'package:flutter_hive/widgets/add_notes.dart';
import 'package:flutter_hive/widgets/delete_notes.dart';
import 'package:flutter_hive/widgets/edit_notes.dart';
import 'package:hive_flutter/adapters.dart';

// HomeScreen widget, which is the main screen of the notes app.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Controllers for handling the input from the text fields.
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final DeleteNotes _deleteNotes = DeleteNotes();  // Create an instance of DeleteNotes class

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // App bar with a title and theme-based color.
        title: const Text('Flutter Hive'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: ValueListenableBuilder(
        // Listens to changes in the Hive box and rebuilds the UI accordingly.
        valueListenable: Boxes.getData().listenable(),
        builder: (context, box, _) {
          var data = box.values.toList().cast<NotesModel>();
          return ListView.builder(
            // Builds a scrollable list of notes.
            itemCount: box.length,
            itemBuilder: (context, index) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize
                        .min, // Allows the column to shrink-wrap its children.
                    children: [
                      Row(
                        children: [
                          Flexible(
                            // Makes the title text flexible within the row.
                            fit: FlexFit.tight,
                            child: Text(
                              data[index].title.toString(),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                          const Spacer(), // Adds space between title and icons.
                          InkWell(
                            onTap: () {
                              // Opens the dialog to edit the note.
                              showDialog(
                                context: context,
                                builder: (context) => EditNotesDialog(
                                  titleController: titleController,
                                  descriptionController: descriptionController,
                                  notesModel: data[index],
                                ),
                              );
                            },
                            child: const Icon(
                              Icons.edit,
                              color: Colors.blue,
                            ),
                          ),
                          const SizedBox(width: 15),
                          InkWell(
                            onTap: () {
                              // Deletes the note.
                              _deleteNotes.deleteNote(data[index]);
                            },
                            child: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                      Flexible(
                        // Allows the description text to be flexible and handle overflow.
                        child: Text(
                          data[index].description.toString(),
                          maxLines: 3, // Limits description to 3 lines.
                          overflow: TextOverflow
                              .ellipsis, // Adds ellipsis if text overflows.
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        // Button to add a new note.
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () async {
          // Opens the dialog to add a new note.
          await showDialog(
            context: context,
            builder: (context) => AddNotesDialog(
              titleController: titleController,
              descriptionController: descriptionController,
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
