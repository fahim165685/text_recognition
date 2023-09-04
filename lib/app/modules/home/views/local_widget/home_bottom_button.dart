import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:text_recognition/app/routes/app_pages.dart';

import '../../../../core/values/app_colors.dart';
import '../../../../core/values/app_space.dart';
import '../../../../core/values/app_svg_assets.dart';
import '../../controllers/home_controller.dart';

class HomeBottomButton extends StatelessWidget {
  const HomeBottomButton({super.key,
    required this.homeController,});

  final HomeController homeController;

  @override
  Widget build(BuildContext context) {
    return Offstage(
      offstage: homeController.textController.value.text.isEmpty,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomIconButton(
              text: "Listen",
              color: homeController.isSpeak ? Colors.black: Colors.black.withOpacity(0.5),
              icon: AppSvgAssets.speakerIcon,
              onTap: (){homeController.textToSpeech();}),

          CustomIconButton(
              text: "Copy Text",
              icon: AppSvgAssets.copyIcon,
              onTap: (){
                homeController.copyToClipboard();
              }),

          CustomIconButton(
              text: "Edit Text",
              icon: AppSvgAssets.editIcon,
              onTap: (){
                homeController.toggleEditText();
              }),

          CustomIconButton(
              text: "Translate",
              icon: AppSvgAssets.translatorIcon,
            onTap: () {
              Get.toNamed(Routes.TRANSLATE, arguments:homeController.textController.text );
            },
              ),
        ],
      ),
    );
  }
}

class CustomIconButton extends StatelessWidget {
  final VoidCallback? onTap;
  final Color? color;
  final String icon;
  final String text;
  const CustomIconButton({
    super.key,
    this.onTap,this.color,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(icon,
                width: 18,
                color: color?? AppColors.black,
                height: 18,
              ),
              AppSpace.spaceH6,
              Text(text,
                style: TextStyle(fontSize: 16, color: onTap != null? AppColors.grey500 :AppColors.grey400 ),
              )
            ],
          ),
        ),
      ),
    );
  }
}