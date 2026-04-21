import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/services/connectivity_services.dart';
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
  final _network = ConnectivityService(); // ✅ use service

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

    // 🔥 optimistic UI
    state = [note, ...state];

    final isOnline = await _network.isConnected(); // ✅ FIX

    await _repo.addNote(note, isOnline: isOnline);
  }

  Future<void> deleteNote(NoteModel note) async {
    // 🔥 optimistic UI
    state = state.where((e) => e.id != note.id).toList();

    final isOnline = await _network.isConnected(); // ✅ FIX

    await _repo.deleteNote(note, isOnline: isOnline);
  }
}