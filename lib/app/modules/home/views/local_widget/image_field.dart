import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:text_recognition/app/core/values/app_svg_assets.dart';

import '../../controllers/home_controller.dart';

class ImageField extends StatelessWidget {
  const ImageField({Key? key, required this.controller}) : super(key: key);
  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return  controller.imageFile == null ? GestureDetector(
      onTap: () => controller.showSelectPhotoOptions(context),
      child: DottedBorder(
        borderType: BorderType.RRect,
        radius: const Radius.circular(8),
        strokeWidth: 2,
        dashPattern: const [4, 4],
        child: SizedBox(
          width: double.infinity,
          height: 200,
          child: Center(
            child: SvgPicture.asset(AppSvgAssets.uploadIcon,
                color: Colors.black, width: 50, height: 50),
          ),
        ),
      ),
    ) : Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Image.file(controller.imageFile!),
    );
  }
}