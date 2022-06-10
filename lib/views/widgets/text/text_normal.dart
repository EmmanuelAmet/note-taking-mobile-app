import 'package:flutter/material.dart';

class TextNormalTile extends StatelessWidget {
  const TextNormalTile({Key? key, required this.text}) : super(key: key);
  final text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.0),
      child: Text(
        text,
        style: TextStyle(fontWeight: FontWeight.normal),
      ),
    );
  }
}
