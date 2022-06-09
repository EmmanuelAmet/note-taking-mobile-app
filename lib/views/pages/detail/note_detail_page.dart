import 'package:flutter/material.dart';
import 'package:note_taking_app/constants/app_dimensions.dart';
import 'package:note_taking_app/views/widgets/spacing/vertical_spacing_widget.dart';
import 'package:note_taking_app/views/widgets/text/text_bold.dart';

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
            child: Container(
              margin: const EdgeInsets.all(AppDimensions.containerMargin),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TextBoldTile(text: AppStrings.title),
                  Padding(
                    padding:
                        const EdgeInsets.only(bottom: AppDimensions.padding1),
                    child: Text(
                      title,
                      style: const TextStyle(fontWeight: FontWeight.normal),
                    ),
                  ),
                  VerticalSpacing(),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 10.0),
                    child: Text(
                      AppStrings.description,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Text(
                      description,
                      style: const TextStyle(fontWeight: FontWeight.normal),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
