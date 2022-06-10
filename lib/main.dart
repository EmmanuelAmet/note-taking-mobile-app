// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:note_taking_app/constants/app_strings.dart';
import 'package:note_taking_app/views/pages/dashboard/dashboard_page.dart';
import 'package:note_taking_app/views/pages/onboarding/onboarding_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'model/note/note_model.dart';

int isViewed;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  isViewed = prefs.getInt(AppStrings.onBoardingPref);
  await Hive.initFlutter();
  Hive.registerAdapter(NoteModelAdapter());
  await Hive.openBox<NoteModel>(AppStrings.hiveBoxName);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      builder: FlutterSmartDialog.init(),
      home: isViewed != 0 ? const OnBoardingPage() : const DashboardPage(),
    );
  }
}
