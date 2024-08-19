import 'package:flutter/material.dart';
import 'package:flutter_hive/models/notes_model.dart';

class EditNotesDialog extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final NotesModel notesModel;

  const EditNotesDialog({
    super.key,
    required this.titleController,
    required this.descriptionController,
    required this.notesModel,
  });

  @override
  Widget build(BuildContext context) {
    // Pre-fill the text fields with the current values of the note
    titleController.text = notesModel.title;
    descriptionController.text = notesModel.description;

    return AlertDialog(
      title: const Text(
        'Edit Notes',
        style: TextStyle(color: Colors.blue),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize
              .min, // Allows the column to shrink-wrap its children.
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
          onPressed: () {
            // Update the note's properties
            notesModel.title = titleController.text;
            notesModel.description = descriptionController.text;

            notesModel.save(); // Saves the updated note

            titleController.clear();
            descriptionController.clear();

            Navigator.of(context).pop(); // Closes the dialog after saving.
          },
          child: const Text(
            'Edit',
            style: TextStyle(
              color: Colors.blue,
            ),
          ),
        ),
      ],
    );
  }
}
