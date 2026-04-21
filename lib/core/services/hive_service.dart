import 'package:hive/hive.dart';

class HiveService {
  static const String noteBox = "notes";
  static const String queueBox = "queue";


  static Future<void> openBoxes() async {
    await Hive.openBox(noteBox);
    await Hive.openBox(queueBox);

  }

  static Box getNoteBox() {
    return Hive.box(noteBox);

  }
  static Box getQueueBox() {
    return Hive.box(queueBox);
  }
}