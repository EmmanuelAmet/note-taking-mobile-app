import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../../constants/app_strings.dart';
import '../../model/note/note_model.dart';
import '../../utils/box.dart';

class AddNoteController extends GetxController {
  Future addNote(String title, String description) async {
    final note = NoteModel()
      ..title = title
      ..createdDate = DateTime.now()
      ..description = description;

    final box = Boxes.getBoxNote();
    box.add(note);
  }

  closeBox() {
    Hive.box(AppStrings.hiveBoxName).close();
  }
}
