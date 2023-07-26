import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

import '../../../../global_widget/custom_drop_down.dart';
import '../../controllers/home_controller.dart';

class Dropdown extends StatelessWidget {
  const Dropdown({
    super.key,
    required this.controller,
  });

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return  Offstage(
      offstage: controller.imageFile == null,
      child: CustomDropdown(
        items: controller.scriptList,
        value: controller.selectedScript,
        onChanged: (value) {
          controller.selectedScript = value as TextRecognitionScript;
        },
        hintText: "Select language Script",
        helperText: "Select language",
      ),
    );
  }
}