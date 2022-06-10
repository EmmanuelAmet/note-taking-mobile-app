import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_taking_app/constants/app_strings.dart';

import '../../../model/note/note_model.dart';

class NoteEditDialog extends StatefulWidget {
  final NoteModel? noteModel;
  final Function(String title, String description) onClickedDone;

  const NoteEditDialog({
    Key? key,
    required this.onClickedDone,
    this.noteModel,
  }) : super(key: key);

  @override
  _NoteEditDialogState createState() => _NoteEditDialogState();
}

class _NoteEditDialogState extends State<NoteEditDialog> {
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.noteModel != null) {
      final note = widget.noteModel!;
      titleController.text = note.title;
      descriptionController.text = note.description;
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.noteModel != null;
    const title = AppStrings.editNote;

    return AlertDialog(
      title: const Text(title),
      content: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(height: 8),
              buildCallbackEndpoint(),
              const SizedBox(height: 8),
              buildNoteDescription(),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        buildCancelButton(context),
        buildAddButton(context, isEditing: isEditing),
      ],
    );
  }

  Widget buildCallbackEndpoint() => TextFormField(
        controller: titleController,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: AppStrings.enterNoteTitle,
        ),
        validator: (name) =>
            name != null && name.isEmpty ? AppStrings.enterNoteTitle : null,
      );

  Widget buildNoteDescription() => TextFormField(
        maxLines: null,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: AppStrings.enterNoteDescription,
        ),
        keyboardType: TextInputType.multiline,
        controller: descriptionController,
      );

  Widget buildCancelButton(BuildContext context) => TextButton(
      child: const Text(AppStrings.cancel), onPressed: () => Get.back());

  Widget buildAddButton(BuildContext context, {required bool isEditing}) {
    final text = isEditing ? AppStrings.save : AppStrings.addNew;

    return TextButton(
      child: Text(text),
      onPressed: () async {
        final isValid = formKey.currentState!.validate();

        if (isValid) {
          final callback = titleController.text;
          final phone = descriptionController.text;
          widget.onClickedDone(callback, phone);
          Get.back();
        }
      },
    );
  }
}
