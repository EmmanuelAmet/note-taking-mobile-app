import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:note_taking_app/constants/app_assets.dart';
import 'package:note_taking_app/constants/app_strings.dart';
import 'package:note_taking_app/model/note/note_model.dart';
import 'package:note_taking_app/views/pages/detail/note_detail_page.dart';
import 'package:note_taking_app/views/pages/note/add_note_page.dart';

import '../../../utils/box.dart';
import '../../../utils/help.dart';
import '../note/edit_note_dialog.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void dispose() {
    Hive.box(AppStrings.hiveBoxName).close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.appName),
      ),
      body: Container(
        child: ValueListenableBuilder<Box<NoteModel>>(
          valueListenable: Boxes.getBoxNote().listenable(),
          builder: (context, box, _) {
            final transactions = box.values.toList().cast<NoteModel>();
            return buildContent(transactions);
          },
        ),
      ),
    );
  }

  Widget buildContent(List<NoteModel> ussdModel) {
    if (ussdModel.isEmpty) {
      return Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(AssetStrings.noData, height: 300, width: 300),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              onPrimary: Colors.white,
            ),
            onPressed: () async {
              Get.to(() => AddNotePage());
            },
            child: const Text(AppStrings.addYourFirstNote),
          ),
        ],
      ));
    } else {
      return Column(
        children: [
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              addAutomaticKeepAlives: true,
              padding: const EdgeInsets.all(8),
              itemCount: ussdModel.length,
              itemBuilder: (BuildContext context, int index) {
                final ussd = ussdModel.reversed.toList()[index];
                return buildUssdDetail(context, ussd);
              },
            ),
          ),
        ],
      );
    }
  }

  Widget buildUssdDetail(
    BuildContext context,
    NoteModel note,
  ) {
    final date = DateFormat.yMMMd().format(note.createdDate);
    final title = note.title;
    final description = note.description;

    return Card(
      color: Colors.white,
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        title: Text(
          title,
          maxLines: 2,
          style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 18),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              description,
              style:
                  const TextStyle(fontWeight: FontWeight.normal, fontSize: 16),
            ),
            Text(date),
          ],
        ),
        children: [
          buildButtons(context, note),
        ],
      ),
    );
  }

  Widget buildButtons(BuildContext context, NoteModel noteModel) => Row(
        children: [
          Expanded(
            child: TextButton.icon(
                label: const Text('Test'),
                icon: const Icon(Icons.dialpad_rounded),
                onPressed: () => {
                      Get.to(() => NoteDetailPage(
                          title: noteModel.title,
                          description: noteModel.description,
                          date: noteModel.createdDate))
                    }),
          ),
          Expanded(
            child: TextButton.icon(
              label: const Text('Edit'),
              icon: const Icon(Icons.edit),
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => NoteEditDialog(
                    noteModel: noteModel,
                    onClickedDone: (title, description) =>
                        noteEditDialog(noteModel, title, description),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: TextButton.icon(
              label: const Text('Delete'),
              icon: const Icon(Icons.delete),
              onPressed: () => {
                //confirmDialog(context, noteModel)
                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.INFO,
                  animType: AnimType.BOTTOMSLIDE,
                  title: AppStrings.confirm,
                  desc: AppStrings.areYouSureYouWantToDelete,
                  btnCancelOnPress: () {},
                  btnOkOnPress: () async {
                    //Delete note
                    await deleteNote(noteModel);
                  },
                )..show()
              },
            ),
          )
        ],
      );

  void noteEditDialog(
    NoteModel noteModel,
    String title,
    String description,
  ) {
    noteModel.title = title;
    noteModel.description = description;
    noteModel.save();
  }

  deleteNote(NoteModel noteModel) {
    noteModel.delete();
  }

  Future<String?> confirmDialog(BuildContext context, NoteModel noteModel) {
    final Helper _helper = Get.put(Helper());
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text(AppStrings.confirm),
        content: const Text(AppStrings.areYouSureYouWantToDelete),
        actions: <Widget>[
          TextButton(
            onPressed: () => Get.back(),
            child: const Text(
              AppStrings.no,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          TextButton(
            onPressed: () async {
              SmartDialog.showLoading();
              await deleteNote(noteModel);
              await _helper.showToastMassage(AppStrings.noteDeletedSuccessful);
              SmartDialog.dismiss();
              Get.back();
            },
            child: const Text(
              AppStrings.yes,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
