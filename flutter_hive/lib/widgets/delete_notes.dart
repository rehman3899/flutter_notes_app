import 'package:flutter_hive/models/notes_model.dart';

class DeleteNotes {
  // Deletes a note from the Hive box.
  Future<void> deleteNote(NotesModel notesModel) async {
    await notesModel.delete();
  }
}
