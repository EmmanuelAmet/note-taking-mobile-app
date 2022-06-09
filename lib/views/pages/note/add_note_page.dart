import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_taking_app/constants/app_strings.dart';
import 'package:note_taking_app/model/note/note_model.dart';
import 'package:note_taking_app/utils/box.dart';
import 'package:note_taking_app/views/widgets/button/round_button.dart';
import 'package:note_taking_app/views/widgets/error/error_widget.dart';
import 'package:note_taking_app/views/widgets/spacing/vertical_spacing_widget.dart';

import '../../../constants/app_dimensions.dart';

class AddNotePage extends StatelessWidget {
  AddNotePage({Key? key}) : super(key: key);
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final isErrorVisible = false.obs;
    var isLoading = false.obs;
    var errorMessage = ''.obs;

    return Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.addNew),
        ),
        body: Container(
          child: Center(
            child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ErrorMessage(
                        visibility: isErrorVisible, message: errorMessage),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 10.0),
                      child: Text(
                        AppStrings.title,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Obx(() => TextField(
                        enabled: isLoading.isTrue ? false : true,
                        controller: titleController,
                        style: TextStyle(fontWeight: FontWeight.bold),
                        enableInteractiveSelection: true,
                        toolbarOptions: const ToolbarOptions(
                            copy: true,
                            paste: true,
                            cut: true,
                            selectAll: true),
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          hintText: AppStrings.enterNoteTitle,
                          hintStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.normal,
                          ),
                          enabledBorder: inputBorder(),
                          focusedBorder: inputBorder(),
                          border: inputBorder(),
                        ))),
                    const VerticalSpacing(),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 10.0),
                      child: Text(
                        AppStrings.description,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Obx(() => TextField(
                        enabled: isLoading.isTrue ? false : true,
                        maxLines: null,
                        controller: descriptionController,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                        enableInteractiveSelection: true,
                        toolbarOptions: const ToolbarOptions(
                            copy: true,
                            paste: true,
                            cut: true,
                            selectAll: true),
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          hintText: AppStrings.enterNoteDescription,
                          hintStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.normal,
                          ),
                          enabledBorder: inputBorder(),
                          focusedBorder: inputBorder(),
                          border: inputBorder(),
                        ))),
                    const VerticalSpacing(),
                    RoundButton(
                        onPressed: () {
                          if (titleController.text.trim().isEmpty) {
                            errorMessage.value = AppStrings.titleFieldRequired;
                            isErrorVisible.value = true;
                            isLoading.value = false;
                          } else {
                            isErrorVisible.value = false;
                            isLoading.value = true;
                          }
                        },
                        childText: AppStrings.save,
                        isLoading: isLoading)
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  OutlineInputBorder inputBorder() {
    return const OutlineInputBorder(
        borderRadius: BorderRadius.all(
            Radius.circular(AppDimensions.textFieldBorderRadius)),
        borderSide: BorderSide(
          color: Colors.grey,
          width: AppDimensions.textFieldBorderWidth,
        ));
  }

  Future addNote(String title, String description) async {
    final note = NoteModel()
      ..title = title
      ..createdDate = DateTime.now()
      ..description = description;

    final box = Boxes.getBoxNot();
    box.add(note);
  }
}