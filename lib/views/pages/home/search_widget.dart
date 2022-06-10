// @dart=2.9
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:note_taking_app/model/note/note_model.dart';
import 'package:note_taking_app/views/widgets/text/text_bold.dart';
import 'package:note_taking_app/views/widgets/text/text_normal.dart';

import '../../../constants/app_assets.dart';
import '../../../utils/box.dart';
import '../detail/note_detail_page.dart';

class SearchWidget extends SearchDelegate<NoteModel> {
  @override
  List<Widget> buildActions(BuildContext context) {
    //***** Clearing the search field
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    //***** Returning back to home
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return SearchFinder(query: query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return SearchFinder(query: query);
  }
}

class SearchFinder extends StatelessWidget {
  final String query;

  const SearchFinder({Key key, this.query}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Boxes.getBoxNote().listenable(),
      builder: (context, Box<NoteModel> contactsBox, _) {
        //***** Filtering data
        var results = query.isEmpty
            ? contactsBox.values.toList()
            : contactsBox.values
                .where((c) => c.title.toLowerCase().contains(query))
                .toList();

        return results.isEmpty
            ? Center(
                child: Lottie.asset(AssetStrings.notFound,
                    height: 300, width: 300),
              )
            : ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: results.length,
                itemBuilder: (context, index) {
                  final NoteModel noteModel = results[index];

                  return ListTile(
                    onTap: () {
                      Get.to(() => NoteDetailPage(
                          title: noteModel.title,
                          description: noteModel.description,
                          date: noteModel.createdDate));
                    },
                    title: Text(
                      noteModel.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextNormalTile(text: noteModel.description),
                        TextBoldTile(
                            text: DateFormat.yMMMd()
                                .format(noteModel.createdDate)),
                        Divider()
                      ],
                    ),
                  );
                },
              );
      },
    );
  }
}
