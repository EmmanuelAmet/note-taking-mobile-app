import 'package:flutter/material.dart';

import '../../../constants/app_strings.dart';

class TextNormalTile extends StatelessWidget {
  const TextNormalTile({Key? key, required this.text}) : super(key: key);
  final text;

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(bottom: 10.0),
      child: Text(
        AppStrings.title,
        style: TextStyle(fontWeight: FontWeight.normal),
      ),
    );
  }
}