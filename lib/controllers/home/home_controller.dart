import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart' as signIn;
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:note_taking_app/constants/app_strings.dart';

import '../../model/note/note_model.dart';
import '../../services/google/google_auth_client.dart';
import '../../utils/helper.dart';

class HomeController extends GetxController {
  final _helper = Get.put(Helper());
  //***** Edit note
  void noteEditDialog(
    NoteModel noteModel,
    String title,
    String description,
  ) {
    noteModel.title = title;
    noteModel.description = description;
    noteModel.save();
  }

  //***** Delete note
  deleteNote(NoteModel noteModel) {
    noteModel.delete();
  }

  //***** Uploading note to Google Drive
  uploadNoteToCloud(note) async {
    //Checking user internet status before uploading notes
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      //***** This wil attempts to login using previously authenticated account without any user interactio
      final googleSignIn =
          signIn.GoogleSignIn.standard(scopes: [drive.DriveApi.driveScope]);
      final signIn.GoogleSignInAccount? account = await googleSignIn.signIn();
      print("User account: $account");

      final authHeaders = await account?.authHeaders;
      final authenticateClient = GoogleAuthClient(authHeaders!);
      final driveApi = drive.DriveApi(authenticateClient);

      final Stream<List<int>> mediaStream =
          Future.value([1104, 105]).asStream();
      var media = new drive.Media(mediaStream, 2);
      var driveFile = new drive.File();
      driveFile.name = "notebook.pdf";
      final result = await driveApi.files.create(driveFile, uploadMedia: media);
      print("Upload result: ${result.name}");
    } else {
      _helper.showToastMassage(AppStrings.noInternetConnectivityAvailable);
    }
  }

  /*
   uploadNoteToCloud() async {
    //Checking user internet status before uploading notes
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      final googleSignIn =
          signIn.GoogleSignIn.standard(scopes: [drive.DriveApi.driveScope]);
      final signIn.GoogleSignInAccount? account = await googleSignIn.signIn();
      print("User account: $account");

      final authHeaders = await account?.authHeaders;
      final authenticateClient = GoogleAuthClient(authHeaders!);
      final driveApi = drive.DriveApi(authenticateClient);

      final Stream<List<int>> mediaStream = Future.value([104, 105]).asStream();
      var media = new drive.Media(mediaStream, 2);
      var driveFile = new drive.File();
      driveFile.name = "notebook.pdf";
      final result = await driveApi.files.create(driveFile, uploadMedia: media);
      print("Upload result: $result");
    } else {
      _helper.showToastMassage(AppStrings.noInternetConnectivityAvailable);
    }
  }
   */
}
