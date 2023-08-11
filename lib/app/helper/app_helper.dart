import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../core/values/app_space.dart';

class AppHelper {

static  void hideKeyboard() {
    FocusScopeNode currentFocus = FocusScope.of(Get.overlayContext!);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }

static void miniSuccessSnackBar({String massage = "Success", double maxWidth = 260 }) {
  Get.rawSnackbar(
    margin: const EdgeInsets.symmetric(horizontal: 15,),
    maxWidth: maxWidth,
    borderColor: Colors.transparent,
    backgroundColor: Colors.transparent,
    snackPosition: SnackPosition.TOP,
    messageText: Container(
      height: 45,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      alignment: Alignment.center,
      decoration: BoxDecoration(color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [BoxShadow(
            color: Colors.black.withOpacity(0.10),
            blurRadius: 15,
            offset: const Offset(5, 10)),]),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.check_circle,
              color: Colors.green, size: 20),
          AppSpace.spaceW8,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                FittedBox(
                  fit: BoxFit.contain,
                  child: Text(massage,
                      style: Get.textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: Get.theme.colorScheme.tertiary)),
                ),
              ],
            ),
          ),
        ],
      ),
    ),

  );
}

static void miniErrorSnackBar({String massage = "Something Was Wrong",double maxWidth = 250 }) {
  Get.rawSnackbar(
    margin: const EdgeInsets.symmetric(
      horizontal: 15,
    ),
    maxWidth: maxWidth,
    borderColor: Colors.transparent,
    backgroundColor: Colors.transparent,
    snackPosition: SnackPosition.TOP,
    messageText: Container(
      height: 45,
      padding:const EdgeInsets.symmetric(horizontal: 15),
      alignment: Alignment.center,
      decoration: BoxDecoration(color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
        BoxShadow(
            color: Colors.black.withOpacity(0.10),
            blurRadius: 15,
            offset: const Offset(5, 10)),]),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.cancel,
              color: Colors.red, size: 20),
          AppSpace.spaceW8,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                FittedBox(
                  fit: BoxFit.contain,
                  child: Text(massage,
                      style: Get.textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: Get.theme.colorScheme.tertiary)),
                ),
              ],
            ),
          ),
        ],
      ),
    ),

  );
}

static void snackBarForError({
  String titleText = "Alert",
  required String message,
  double? topMargin,
  int duration = 3000,
}) {
  Get.snackbar(titleText, message,
      snackPosition: SnackPosition.TOP,
      duration: Duration(milliseconds:duration),
      margin: EdgeInsets.only(
          top: topMargin ?? Get.height * 0.0,
          left: Get.width * 0.05,
          right: Get.width * 0.05),
      backgroundColor: Colors.red.withOpacity(0.9),
      colorText: Colors.white);
}

static void snackBarForSuccess({
  String titleText = "Success",
  required String bodyText,
  int duration = 3000,
  double? topMargin,
}) {
  Get.snackbar(titleText, bodyText,
      snackPosition: SnackPosition.TOP,
      duration: Duration(milliseconds: duration),
      margin: EdgeInsets.only(
          top: topMargin ?? Get.height * 0.0,
          left: Get.width * 0.05,
          right: Get.width * 0.05),
      padding: const EdgeInsets.all(8),
      icon: const Icon(Icons.cloud_done_outlined,
          color: Colors.green, size: 30),
      // backgroundColor: fromHex('#E9A9AF'),
      colorText: Colors.black);
}

}