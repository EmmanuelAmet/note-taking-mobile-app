import 'package:get/get.dart';

import '../../model/note/note_model.dart';

class HomeController extends GetxController {
  //***** Edit note
  void noteEditDialog(
    NoteModel noteModel,
    String title,
    String description,
  ) {
    noteModel.title = title;
    noteModel.description = description;
    noteModel.save();
  }

  //***** Delete note
  deleteNote(NoteModel noteModel) {
    noteModel.delete();
  }
}
