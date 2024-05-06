// ignore_for_file: invalid_use_of_protected_member, avoid_print

// import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/app_fontweights.dart';
// import '../../service/getx_service/network_service.dart';
import '../custom_widgets/common_text.dart';
// import '../../../routes/app_pages.dart';
import '../../config/app_colors.dart';
// import '../../service/service_handler.dart/user_store.dart';
import '../custom_widgets/logo_loader.dart';

// custom dialogs for app alerts
// loaders
class Dialogs {
  static void showSnackbar(String title, String msg) {
    Get.snackbar(title, msg, colorText: AppColors.appColorWhite);
  }

  static void showProgressBar() {
    Get.dialog(
      Center(
        child: LogoLoader(),
      ),
    );
  }

  static void createSnackBar(String message, int code) {
    final snackBar = SnackBar(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        content: Text(message),
        backgroundColor: code == 0
            ? Colors.red
            : code == 1
                ? Colors.green
                : Colors.grey.shade700);

    // Find the Scaffold in the Widget tree and use it to show a SnackBar!
    ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
  }

/*
// Network Message with navigations
  static void showNetworkMessageForSplash() {
    Get.dialog(
      barrierDismissible: false,
      AlertDialog(
        backgroundColor: Get.theme.colorScheme.secondary,
        content: Text(
          'No internet connection\nConnect to internet and retry', // "Are you sure you want to go back, all your changes will be discarded",
          style: TextStyle(fontSize: 17, color: Get.theme.colorScheme.onSecondary),
          textAlign: TextAlign.center,
        ),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(foregroundColor: Get.theme.colorScheme.onSecondary),
            onPressed: () {
              exit(0);
            },
            child: Text(
              "Exit",
              style: TextStyle(fontWeight: AppFontWeights.appTextFontWeightMedium, color: Get.theme.colorScheme.onSecondary),
            ),
          ),
          TextButton(
            style: TextButton.styleFrom(backgroundColor: Get.theme.colorScheme.tertiary, foregroundColor: Get.theme.colorScheme.onSecondary),
            onPressed: () async {
              await GetXNetworkManager.to.checkConnectivity();
              Get.back();
              Dialogs.showProgressBar();
              Future.delayed(const Duration(seconds: 2), () {
                if (GetXNetworkManager.to.connectionType == 0) {
              
                  Dialogs.hideProgressBar();
                  Dialogs.showNetworkMessageForSplash();
                } else {
                  Dialogs.hideProgressBar();
                  // ONLY FOR SPLASH -------------
                  if (Get.currentRoute == PageNames.splashscreen) {
                    if (UserStore.to.profile.value != {} && UserStore.to.profile.value["GUID"] != null && UserStore.to.profile.value.isNotEmpty) {

                      Get.offAndToNamed(PageNames.dashBoardScreen);
                    } else {
                      Get.offAndToNamed(PageNames.loginScreen);
                    }
                  }
                  // For Other Routes
                  else {
                    Get.offAndToNamed(PageNames.dashBoardScreen);
                  }
                }
              });
            },
            child: const Text("Retry"),
          ),
        ],
      ),
    );
  }
*/
// Hides Progress indicator
  static void hideProgressBar() {
    Get.back();
  }

// Custom  Dialog box (ONLY: OK)
  static void showAlertDialog(String message) {
    Get.defaultDialog(
        title: "Alert",
        content: Text(message, style: const TextStyle(), textAlign: TextAlign.center),
        contentPadding: const EdgeInsets.all(20.0),
        cancel: Container(),
        confirm: SizedBox(
          width: 100,
          child: ElevatedButton(
            onPressed: () async {
              Get.back();
            },
            child: const CommonText(
              text: "Ok",
            ),
          ),
        ),
        radius: 10.0,
        titlePadding: const EdgeInsets.fromLTRB(0, 15, 0, 0));
  }

// Custom DIalog Box (WITH YES AND NO)
  static showCustomAlertDialog(context, text, onYes, onNo) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Get.theme.colorScheme.secondary,
        content: Text(
          text,
          style: TextStyle(fontSize: 17, fontWeight: AppFontWeights.appTextFontWeightLight, color: Get.theme.colorScheme.onSecondary),
          textAlign: TextAlign.center,
        ),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(foregroundColor: Get.theme.colorScheme.onSecondary),
            onPressed: onNo,
            child: Text(
              "No",
              style: TextStyle(fontWeight: AppFontWeights.appTextFontWeightMedium, color: Get.theme.colorScheme.onSecondary),
            ),
          ),
          TextButton(
            style: TextButton.styleFrom(backgroundColor: Get.theme.colorScheme.tertiary, foregroundColor: Get.theme.colorScheme.onSecondary),
            onPressed: onYes,
            child: const Text("Yes"),
          ),
        ],
      ),
    );
  }
}
