import 'package:hive/hive.dart';

// This annotation is necessary for code generation, linking this part file to the generated code.
part 'notes_model.g.dart';

// Annotation indicating that this class is a Hive type with a specified type ID.
@HiveType(typeId: 0)
class NotesModel extends HiveObject {
  // Field annotations specifying the order of fields in the serialized data.

  @HiveField(0)
  String title; // The title of the note.

  @HiveField(1)
  String description; // The description of the note.

  // Constructor requiring a title and description for the note.
  NotesModel({required this.title, required this.description});
}
