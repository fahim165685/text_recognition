import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

import '../../../../global_widget/custom_button.dart';
import '../../controllers/home_controller.dart';

class UploadOrScanButton extends StatelessWidget {
  const UploadOrScanButton({
    super.key,
    required this.controller,});

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return  Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            child: CustomButton(
                showBorderOnly: true,
                borderColor: Colors.purple,
                textColor: Colors.purple,
                text: controller.imageFile == null? "Upload Image" : "Upload Image Again",
                height: 50,
                onTap: () => controller.showSelectPhotoOptions(context))),
        const SizedBox(
          width: 10,
        ),
        if ((controller.imageFile != null))
          Expanded(
              child: CustomButton(
                  text: "Convert To Text",
                  onTap: (controller.isLoading) ? null : () {
                    final InputImage inputImage = InputImage.fromFilePath(controller.imageFile!.path);
                    controller.processImage(inputImage);
                  }))
      ],
    );
  }
}