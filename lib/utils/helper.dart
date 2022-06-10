import 'package:flutter_share/flutter_share.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:note_taking_app/constants/app_strings.dart';

class Helper {
  shareNote(title, description) async {
    await FlutterShare.share(
        title: title,
        text: '$title\n\n$description',
        linkUrl: '',
        chooserTitle: AppStrings.appName);
  }

  showToastMassage(message) {
    SmartDialog.showToast(
      message,
    );
  }
}
