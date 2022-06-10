import 'package:hive/hive.dart';

part 'note_model.g.dart';

@HiveType(typeId: 0)
class NoteModel extends HiveObject {
  @HiveField(0)
  late String title;

  @HiveField(1)
  late DateTime createdDate;

  @HiveField(2)
  late String description;
}
