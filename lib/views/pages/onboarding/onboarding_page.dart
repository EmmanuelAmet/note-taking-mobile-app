import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:note_taking_app/constants/app_strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants/app_colors.dart';
import '../../../controllers/onboarding/onboarding_controller.dart';
import '../dashboard/dashboard_page.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final OnBoardingController _onBoardingController =
      Get.put(OnBoardingController());
  _storeOnboardInfo() async {
    print("Shared pref called");
    int isViewed = 0;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(AppStrings.onBoardingPref, isViewed);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        body: Container(
          child: SafeArea(
            child: Stack(
              children: [
                PageView.builder(
                    controller: _onBoardingController.pageNavigation,
                    onPageChanged: _onBoardingController.selectedPageIndex,
                    itemCount: _onBoardingController.onBoardingPages.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Lottie.asset(_onBoardingController
                                .onBoardingPages[index].imageAsset),
                            const SizedBox(height: 5),
                            Text(
                              _onBoardingController
                                  .onBoardingPages[index].title,
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.blue),
                            ),
                            const SizedBox(height: 10),
                            Center(
                              child: Text(
                                _onBoardingController
                                    .onBoardingPages[index].description,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                Positioned(
                    bottom: 20,
                    left: 20,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(
                            _onBoardingController.onBoardingPages.length,
                            (index) => Obx(() {
                                  return Container(
                                    margin: const EdgeInsets.all(3),
                                    width: 8,
                                    height: 8,
                                    decoration: BoxDecoration(
                                      color: _onBoardingController
                                                  .selectedPageIndex.value ==
                                              index
                                          ? AppColors.orange
                                          : Colors.grey,
                                      shape: BoxShape.circle,
                                    ),
                                  );
                                })),
                      ),
                    )),
                Positioned(
                  bottom: 20,
                  right: 30,
                  child: FloatingActionButton(
                    backgroundColor: AppColors.blue,
                    onPressed: () {
                      _onBoardingController.forwardAction();
                      _onBoardingController.isLastPage
                          ? Get.to(() => const DashboardPage())
                          : null;
                      _storeOnboardInfo();
                    },
                    child: Obx(() {
                      return Text(
                        _onBoardingController.isLastPage
                            ? AppStrings.start
                            : AppStrings.next,
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      );
                    }),
                  ),
                ),
                Positioned(
                  top: 50,
                  right: 30,
                  child: InkWell(
                      onTap: () {
                        _storeOnboardInfo();
                        Get.to(() => const DashboardPage());
                      },
                      child: const Text(AppStrings.skip,
                          style: TextStyle(
                              fontSize: 18,
                              color: AppColors.blue,
                              fontWeight: FontWeight.bold))),
                ),
              ],
            ),
          ),
        ));
  }
}
