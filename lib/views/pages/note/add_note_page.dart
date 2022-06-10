import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_taking_app/constants/app_strings.dart';
import 'package:note_taking_app/controllers/addnote/add_note_controller.dart';
import 'package:note_taking_app/views/pages/dashboard/dashboard_page.dart';
import 'package:note_taking_app/views/widgets/button/round_button.dart';
import 'package:note_taking_app/views/widgets/error/error_widget.dart';
import 'package:note_taking_app/views/widgets/spacing/vertical_spacing_widget.dart';
import 'package:note_taking_app/views/widgets/text/text_bold.dart';

import '../../../constants/app_dimensions.dart';

class AddNotePage extends StatelessWidget {
  AddNotePage({Key? key}) : super(key: key);
  //***** Dependency Injection
  final _addNoteController = Get.put(AddNoteController());

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
                    const TextBoldTile(text: AppStrings.title),
                    Obx(() => TextField(
                        enabled: isLoading.isTrue ? false : true,
                        controller: titleController,
                        style: const TextStyle(fontWeight: FontWeight.normal),
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
                            fontWeight: FontWeight.normal,
                            fontStyle: FontStyle.normal,
                          ),
                          enabledBorder: inputBorder(),
                          focusedBorder: inputBorder(),
                          border: inputBorder(),
                        ))),
                    const VerticalSpacing(),
                    const TextBoldTile(text: AppStrings.description),
                    Obx(() => TextField(
                        enabled: isLoading.isTrue ? false : true,
                        maxLines: null,
                        controller: descriptionController,
                        style: const TextStyle(fontWeight: FontWeight.normal),
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
                            fontWeight: FontWeight.normal,
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
                            _addNoteController.addNote(
                                titleController.text.trim(),
                                descriptionController.text.trim());
                            Get.offAll(() => DashboardPage());
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
}
