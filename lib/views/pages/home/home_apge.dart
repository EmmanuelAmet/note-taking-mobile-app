import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:note_taking_app/constants/app_assets.dart';
import 'package:note_taking_app/constants/app_colors.dart';
import 'package:note_taking_app/constants/app_strings.dart';
import 'package:note_taking_app/model/note/note_model.dart';
import 'package:note_taking_app/views/pages/detail/note_detail_page.dart';
import 'package:note_taking_app/views/pages/note/add_note_page.dart';

import '../../../utils/box.dart';
import '../../../utils/help.dart';
import '../note/edit_note_dialog.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);
  final _helper = Get.put(Helper());

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
                label: const Text(
                  AppStrings.view,
                  style: TextStyle(color: AppColors.green),
                ),
                icon: const Icon(
                  CupertinoIcons.info,
                  color: AppColors.green,
                ),
                onPressed: () => {
                      Get.to(() => NoteDetailPage(
                          title: noteModel.title,
                          description: noteModel.description,
                          date: noteModel.createdDate))
                    }),
          ),
          Expanded(
            child: TextButton.icon(
              label: const Text(AppStrings.edit),
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
              label: const Text(
                AppStrings.delete,
                style: TextStyle(color: AppColors.red),
              ),
              icon: const Icon(
                CupertinoIcons.delete,
                color: AppColors.red,
              ),
              onPressed: () => {
                //confirmDialog(context, noteModel)
                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.QUESTION,
                  animType: AnimType.BOTTOMSLIDE,
                  title: AppStrings.confirm,
                  desc: AppStrings.areYouSureYouWantToDelete,
                  btnCancelOnPress: () {},
                  btnOkOnPress: () async {
                    //Delete note
                    await deleteNote(noteModel);
                    widget._helper
                        .showToastMassage(AppStrings.noteDeletedSuccessful);
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
}
