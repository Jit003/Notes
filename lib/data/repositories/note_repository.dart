import '../local/local_data_source.dart';
import '../local/queue_local_data_source.dart';
import '../models/queue_item_model.dart';
import '../remote/firebase_service.dart';
import '../models/note_model.dart';

class NoteRepository {
  final _local = LocalDataSource();
  final _remote = FirebaseService();
  final _queue = QueueLocalDataSource();


  Future<void> addNote(NoteModel note, {required bool isOnline}) async {
    await _local.saveNote(note);

    if (isOnline) {
      await _remote.addNote(note);
    } else {
      final queueItem = QueueItemModel(
        id: note.id, // idempotency
        type: "add_note",
        payload: note.toJson(),
      );

      await _queue.addToQueue(queueItem);

    }
  }

  Future<List<NoteModel>> getNotes() async {
    final localNotes = _local.getNotes();

    try {
      final remoteNotes = await _remote.fetchNotes();

      for (var note in remoteNotes) {
        await _local.saveNote(note);
      }

      // 🔥 Always return local DB (source of truth)
      return _local.getNotes();

    } catch (e) {
      return localNotes;
    }
  }

  List<NoteModel> getLocalNotes() {
    return _local.getNotes();
  }
  Future<void> deleteNote(NoteModel note, {required bool isOnline}) async {
    await _local.deleteNote(note.id);

    if (isOnline) {
      await _remote.deleteNote(note.id);
    } else {
      final queueItem = QueueItemModel(
        id: note.id,
        type: "delete_note",
        payload: {"id": note.id},
      );

      await _queue.addToQueue(queueItem);
    }
  }
}