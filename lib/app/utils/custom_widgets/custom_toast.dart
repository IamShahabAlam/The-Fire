import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../config/app_colors.dart';
import '../../config/app_fontweights.dart';
import '../../config/app_size_config.dart';
import 'common_text.dart';

class MyToast {
  static snackToast(String message, int code, [bool setMiddle = false]) {
    var img = code == 0
        ? 'error_lottie'
        : code == 1
            ? 'success_lottie'
            : 'info_lottie';

    var color = code == 0
        ? AppColors.errorColorDark
        : code == 1
            ? AppColors.successColorDark
            : Get.theme.colorScheme.outline;
    ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
        duration: const Duration(seconds: 2),
        dismissDirection: DismissDirection.horizontal,
        backgroundColor: color.withOpacity(0.7),
        shape: const StadiumBorder(),
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(bottom: setMiddle ? Get.height * 0.4 : 0),
        content: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Lottie.asset(
                options: LottieOptions(),
                animate: true,
                'assets/lottie/$img.json',
                frameRate: FrameRate.composition,
                height: 40,
                fit: BoxFit.fill,
                alignment: Alignment.center,
                addRepaintBoundary: false,
              ),
              CommonText(
                text: message,
                color: Colors.white,
                weight: AppFontWeights.appTextFontWeightMedium,
              ).fittedBox(280, BoxFit.scaleDown),
            ],
          ),
        )));
  }
}
