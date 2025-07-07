import 'package:hive/hive.dart';

part 'journal_entry.g.dart';

// Code Adapted from DhiWise (2024)
@HiveType(typeId: 0)
class JournalEntry extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  String content;

  @HiveField(2)
  DateTime date;

  @HiveField(3)
  int color;

  @HiveField(4)
  List<String> imagePaths;

  JournalEntry({
    required this.title,
    required this.content,
    required this.date,
    required this.color,
    this.imagePaths = const [],
  });
}

//end of adaptation
