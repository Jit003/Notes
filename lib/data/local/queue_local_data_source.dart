import '../../core/services/hive_service.dart';
import '../models/queue_item_model.dart';

class QueueLocalDataSource {
  final box = HiveService.getQueueBox();

  Future<void> addToQueue(QueueItemModel item) async {
    await box.put(item.id, item.toJson());
  }

  List<QueueItemModel> getQueue() {
    return box.values
        .map((e) => QueueItemModel.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }

  Future<void> removeFromQueue(String id) async {
    await box.delete(id);
  }
}