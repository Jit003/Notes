import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/note_model.dart';

class FirebaseService {
  final _db = FirebaseFirestore.instance;

  Future<void> addNote(NoteModel note) async {
    await _db.collection('notes').doc(note.id).set(note.toJson());
  }

  Future<List<NoteModel>> fetchNotes() async {
    final snapshot = await _db.collection('notes').get();

    return snapshot.docs
        .map((doc) => NoteModel.fromJson(doc.data()))
        .toList();
  }
  Future<void> addNoteFromJson(Map<String, dynamic> json) async {
    await _db.collection('notes').doc(json['id']).set(json);
  }
  Future<void> deleteNote(String id) async {
    await _db.collection('notes').doc(id).delete();
  }
}