import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../core/values/app_colors.dart';
import '../../../../core/values/app_space.dart';
import '../../../../core/values/app_svg_assets.dart';
import '../../controllers/home_controller.dart';

class HomeBottomButton extends StatelessWidget {
  const HomeBottomButton({
    super.key,
    required this.homeController,
  });
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
              text: "Copy Text",
              icon: AppSvgAssets.copyIcon,
              onTap: (){}),

          CustomIconButton(
              text: "Edit Text",
              icon: AppSvgAssets.editIcon,
              onTap: (){
                homeController.editText();
              }),

          CustomIconButton(
              text: "Translate",
              icon: AppSvgAssets.translatorIcon,
              ),
        ],
      ),
    );
  }
}

class CustomIconButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String icon;
  final String text;
  const CustomIconButton({
    super.key,
    this.onTap,
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
              SvgPicture.asset(
                icon,
                width: 18,
                color: onTap != null? AppColors.black :AppColors.grey400 ,
                height: 18,
              ),
              AppSpace.spaceH6,
              Text(
                text,
                style: TextStyle(fontSize: 16, color: onTap != null? AppColors.grey500 :AppColors.grey400 ),
              )
            ],
          ),
        ),
      ),
    );
  }
}