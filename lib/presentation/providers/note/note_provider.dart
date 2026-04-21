import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/note_model.dart';
import '../../../data/repositories/note_repository.dart';

final noteProvider = StateNotifierProvider<NoteNotifier, List<NoteModel>>((
  ref,
) {
  return NoteNotifier();
});

class NoteNotifier extends StateNotifier<List<NoteModel>> {
  bool isLoading = true;

  NoteNotifier() : super([]) {
    loadNotes();
  }

  final _repo = NoteRepository();

  Future<void> loadNotes() async {
    isLoading = true;

    final notes = await _repo.getNotes();

    state = notes;
    isLoading = false;
  }

  Future<void> addNote(String text) async {
    final note = NoteModel(
      id: DateTime.now().toString(),
      text: text,
      updatedAt: DateTime.now(),
    );

    // 🔥 STEP 1: Update UI instantly
    state = [note, ...state];
    final connectivityResult = await Connectivity().checkConnectivity();
    final isOnline = connectivityResult != ConnectivityResult.none;

    // 🔥 STEP 2: Do actual work in background
    await _repo.addNote(note, isOnline: isOnline);
  }
  Future<void> deleteNote(NoteModel note) async {
    final connectivityResult = await Connectivity().checkConnectivity();
    final isOnline = connectivityResult != ConnectivityResult.none;

    // 🔥 update UI instantly
    state = state.where((e) => e.id != note.id).toList();

    await _repo.deleteNote(note, isOnline: isOnline);
  }
}
