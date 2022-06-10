import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/app_colors.dart';
import '../spacing/horizontal_spacing_widget.dart';

class RoundButton extends StatelessWidget {
  RoundButton(
      {Key? key,
      required this.onPressed,
      required this.childText,
      required this.isLoading})
      : super(key: key);
  final VoidCallback onPressed;
  final String childText;
  var isLoading = false.obs;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          gradient: const LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              AppColors.blue,
              Colors.lightBlue,
            ],
          ),
        ),
        child: Container(
            margin: const EdgeInsets.all(13.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  childText,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                const HorizontalSpacing(),
                Obx(() => Visibility(
                      visible: isLoading.value,
                      child: SizedBox(
                          height: 18,
                          width: 18,
                          child: CircularProgressIndicator(
                            valueColor:
                                new AlwaysStoppedAnimation<Color>(Colors.white),
                          )),
                    ))
              ],
            )),
      ),
    );
  }
}
