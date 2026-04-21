class NoteModel {
  final String id;
  final String text;
  final DateTime updatedAt;

  NoteModel({
    required this.id,
    required this.text,
    required this.updatedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      id: json['id'],
      text: json['text'],
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}