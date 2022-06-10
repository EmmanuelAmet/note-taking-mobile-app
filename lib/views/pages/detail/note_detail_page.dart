import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:note_taking_app/views/widgets/text/text_bold.dart';
import 'package:note_taking_app/views/widgets/text/text_normal.dart';

import '../../../constants/app_strings.dart';

class NoteDetailPage extends StatelessWidget {
  const NoteDetailPage({Key? key, this.title, this.description, this.date})
      : super(key: key);
  final title, description, date;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.noteDetail),
        ),
        body: Container(
          child: SingleChildScrollView(
            child: ListTile(
              title: Text(title),
              subtitle: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextBoldTile(text: DateFormat.yMMMd().format(date)),
                  TextNormalTile(text: description)
                ],
              ),
            ),
          ),
        ));
  }
}
