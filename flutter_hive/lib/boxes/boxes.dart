import 'package:flutter_hive/models/notes_model.dart';
import 'package:hive/hive.dart';

// Class that provides access to Hive boxes containing NotesModel data.
class Boxes {
  // Static method to get a Box of NotesModel, identified by the name 'notes'.
  static Box<NotesModel> getData() => Hive.box<NotesModel>('notes');
}
