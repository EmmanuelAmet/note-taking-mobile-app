import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../../constants/app_strings.dart';
import '../../model/note/note_model.dart';
import '../../utils/box.dart';

class AddNoteController extends GetxController {
  var isSpeaking = false.obs;
  var speechText = ''.obs;
  late SpeechToText speechToText;

  Future addNote(String title, String description) async {
    final note = NoteModel()
      ..title = title
      ..createdDate = DateTime.now()
      ..description = description;

    final box = Boxes.getBoxNote();
    box.add(note);
  }

  @override
  void onInit() {
    super.onInit();
    speechToText = SpeechToText();
  }

  @override
  void onClose() {
    closeBox();
    super.onClose();
  }

  closeBox() {
    Hive.box(AppStrings.hiveBoxName).close();
  }

  listen() async {
    if (isSpeaking.value) {
      bool available =
          await speechToText.initialize(onStatus: (val) {}, onError: (val) {});
      if (available) {
        isSpeaking.value = true;
        speechToText.listen(onResult: (val) {
          speechText.value = val.recognizedWords;
        });
      }
    } else {
      speechToText.stop();
      isSpeaking.value = false;
    }
  }
}
