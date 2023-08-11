import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/values/app_colors.dart';
import '../core/values/app_space.dart';

//ignore: must_be_immutable
class CustomButton extends StatelessWidget {
  CustomButton({
    super.key,
    required this.onTap,
    required this.text,
    this.textColor = Colors.white,
    this.height = 52,
    this.width = double.infinity,
    this.borderRadius = 50,
    this.showTextOnly = false,
    this.fontSize = 14,
    this.fontWeight = FontWeight.w500,
    this.icon,
    this.buttonColor,
    this.showBorderOnly = false,
    this.borderColor = Colors.white38,
    this.textUnderline = false,
  });

  final VoidCallback? onTap;
  final String text;
  final bool showTextOnly;
  final Color textColor;
  final Color? buttonColor;
  final Color borderColor;
  final double fontSize;
  final FontWeight fontWeight;
  final double height;
  final double width;
  final double borderRadius;
  final bool showBorderOnly;
  final bool textUnderline;
  Widget? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: (showBorderOnly == false)
            ? null
            : Border.all(
            color: borderColor,
            width: 1.5,
            strokeAlign: BorderSide.strokeAlignInside),
        color: (showBorderOnly == false) ?  (showTextOnly == false)? (buttonColor == null) ? AppColors.appColor : buttonColor :null : null,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(borderRadius),
          child: SizedBox(
            width: width,
            height: height,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    child: icon,
                  ),
                  if ((icon == null) == false) AppSpace.spaceW6,
                  if (text.isEmpty == false)
                    Flexible(
                      child: FittedBox(
                        child: Text(text,
                            style: Get.textTheme.titleLarge!.copyWith(
                                decoration:textUnderline ? TextDecoration.underline : null,
                                color: textColor,
                                fontSize: fontSize,
                                fontWeight: fontWeight)),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
