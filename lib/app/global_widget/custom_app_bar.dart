import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../core/values/app_colors.dart';
import '../core/values/app_svg_assets.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.title = '',
    this.icon = AppSvgAssets.arrowBackIcon,
    this.backButton=false,
    this.iconSize=40,
  });
  final String title;
  final String icon;
  final double iconSize;
  final bool backButton;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(10),
              bottomLeft: Radius.circular(10)
          )
      ),
      leading: (backButton == true)
          ? Padding(
              padding: const EdgeInsets.all(10),
              child: InkWell(
                onTap: () {
                  Get.back();
                },
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.borderColor),
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      icon,
                      height: iconSize,
                    ),
                  ),
                ),
              ),
            )
          : const SizedBox.shrink(),
      title: Text(
        title,
        style: const TextStyle(
         fontWeight: FontWeight.w500,
         fontSize: 18,
         color: AppColors.appColor
        ),
      ),
      centerTitle: true,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size(Get.width, 60);
}
