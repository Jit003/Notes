import '../../core/services/hive_service.dart';
import '../models/note_model.dart';

class LocalDataSource {

  final box = HiveService.getNoteBox();

  Future<void> saveNote(NoteModel note) async {
    await box.put(note.id, note.toJson());
  }

  List<NoteModel> getNotes() {
    final data = box.values.toList();

    final notes = data
        .map((e) => NoteModel.fromJson(Map<String, dynamic>.from(e)))
        .toList();

    // 🔥 sort latest first
    notes.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));

    return notes;
  }

  Future<void> deleteNote(String id) async {
    await box.delete(id);
  }
}