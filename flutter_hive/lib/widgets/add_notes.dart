import 'package:flutter/material.dart';
import 'package:flutter_hive/boxes/boxes.dart';
import 'package:flutter_hive/models/notes_model.dart';

class AddNotesDialog extends StatelessWidget {
  
  final TextEditingController titleController;
  final TextEditingController descriptionController;

  const AddNotesDialog({super.key, required this.titleController, required this.descriptionController});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Add Notes',
        style: TextStyle(color: Colors.blue),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min, // Allows the column to shrink-wrap its children.
          children: [
            TextFormField(
              controller: titleController,
              decoration: const InputDecoration(
                hintText: 'Enter the title',
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: descriptionController,
              decoration: const InputDecoration(
                hintText: 'Enter the description',
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Closes the dialog.
          },
          child: const Text(
            'Cancel',
            style: TextStyle(
              color: Colors.blue,
            ),
          ),
        ),
        TextButton(
          onPressed: () async {
            final data = NotesModel(
              title: titleController.text,
              description: descriptionController.text,
            );

            final box = Boxes.getData();
            box.add(data); // Adds the new note to the Hive box.

            
            print(box);

            titleController.clear();
            descriptionController.clear();
            Navigator.of(context).pop(); // Closes the dialog after adding.
          },
          child: const Text(
            'Add',
            style: TextStyle(
              color: Colors.blue,
            ),
          ),
        ),
      ],
    );
  }
}
