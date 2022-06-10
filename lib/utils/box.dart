import 'package:hive/hive.dart';
import 'package:note_taking_app/constants/app_strings.dart';
import 'package:note_taking_app/model/note/note_model.dart';

class Boxes {
  static Box<NoteModel> getBoxNote() =>
      Hive.box<NoteModel>(AppStrings.hiveBoxName);
}
