import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:note_taking_app/constants/app_assets.dart';
import 'package:note_taking_app/constants/app_strings.dart';

import '../../model/onboarding/onboarding.dart';

class OnBoardingController extends GetxController {
  var selectedPageIndex = 0.obs;
  bool get isLastPage => selectedPageIndex.value == onBoardingPages.length - 1;
  var pageNavigation = PageController();
  forwardAction() {
    if (!isLastPage) {
      pageNavigation.nextPage(duration: 300.milliseconds, curve: Curves.ease);
    } else {
      pageNavigation.page;
    }
  }

  List<OnBoardingModel> onBoardingPages = [
    OnBoardingModel(AppStrings.titleOne, AppStrings.descriptionOne,
        AssetStrings.onBoardingOne),
    OnBoardingModel(AppStrings.titleTwo, AppStrings.descriptionTwo,
        AssetStrings.onBoardingTwo),
    OnBoardingModel(AppStrings.titleThree, AppStrings.descriptionThree,
        AssetStrings.onBoardingThree),
  ];
}
