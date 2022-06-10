import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../constants/app_colors.dart';

class ErrorMessage extends StatelessWidget {
  ErrorMessage({Key? key, required this.visibility, required this.message})
      : super(key: key);
  var visibility = false.obs;
  var message = ''.obs;

  @override
  Widget build(BuildContext context) {
    return Obx(()=>Visibility(
      visible: visibility.value,
      child: Container(
        padding: EdgeInsets.all(5.0),
        margin: EdgeInsets.only(bottom: 10.0),
        decoration: BoxDecoration(
            color: AppColors.errorColor,
            borderRadius: BorderRadius.circular(5.0)),
        child: Row(
          children: [
            Icon(
              CupertinoIcons.clear_circled,
              color: AppColors.red,
            ),
            SizedBox(
              width: 10,
            ),
            Obx(() => Text(
              message.value,
              style: TextStyle(
                  color: AppColors.red, fontWeight: FontWeight.bold),
            ))
          ],
        ),
      ),
    ));
  }
}
