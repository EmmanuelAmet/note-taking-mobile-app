import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:note_taking_app/constants/app_strings.dart';
import 'package:note_taking_app/views/pages/note/add_note_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  var currentIndex = 0;
  final pages = [
    Container(
      child: Center(
        child: const Text('Home'),
      ),
    ),
    AddNotePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        //backgroundColor: AppColors.pageBg,
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        //selectedItemColor: AppColors.primary,
        onTap: (index) => setState(() => currentIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.house),
            label: AppStrings.home,
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.add_circled),
            label: AppStrings.addNew,
          ),
        ],
      ),
      body: IndexedStack(
        index: currentIndex,
        children: pages,
      ),
    );
  }
}
