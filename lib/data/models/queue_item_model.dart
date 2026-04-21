class QueueItemModel {
  final String id; // idempotency key
  final String type; // add_note
  final Map<String, dynamic> payload;
  final int retryCount;

  QueueItemModel({
    required this.id,
    required this.type,
    required this.payload,
    this.retryCount = 0,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'type': type,
    'payload': payload,
    'retryCount': retryCount,
  };

  factory QueueItemModel.fromJson(Map<String, dynamic> json) {
    return QueueItemModel(
      id: json['id'],
      type: json['type'],
      payload: Map<String, dynamic>.from(json['payload']),
      retryCount: json['retryCount'] ?? 0,
    );
  }
}