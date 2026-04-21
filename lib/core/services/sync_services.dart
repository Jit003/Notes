import '../../data/local/queue_local_data_source.dart';
import '../../data/remote/firebase_service.dart';
import '../../data/models/queue_item_model.dart';

class SyncService {
  final _queue = QueueLocalDataSource();
  final _remote = FirebaseService();

  Future<void> processQueue() async {
    final items = _queue.getQueue();

    print("[SYNC] Queue size: ${items.length}");

    for (var item in items) {
      try {
        print("[SYNC] Processing: ${item.id}");

        if (item.type == "add_note") {
          await _remote.addNoteFromJson(item.payload);
        }

        if (item.type == "delete_note") {
          await _remote.deleteNote(item.payload["id"]);
        }

        await _queue.removeFromQueue(item.id);
        print("[SYNC] Success: ${item.id}");

      } catch (e) {
        print("[SYNC] Failed: ${item.id}");

        if (item.retryCount < 1) {
          // 🔥 wait before retry
          await Future.delayed(const Duration(seconds: 2));

          final updated = QueueItemModel(
            id: item.id,
            type: item.type,
            payload: item.payload,
            retryCount: item.retryCount + 1,
          );

          await _queue.addToQueue(updated);

          print("[SYNC] Retrying: ${item.id}");
        } else {
          print("[SYNC] Dropped after retry: ${item.id}");
        }
      }
    }
  }}
