import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import '../../../../core/values/app_colors.dart';
import '../../../../core/values/app_space.dart';
import '../../controllers/home_controller.dart';

class ScanResult extends StatelessWidget {
  const ScanResult({
    super.key,
    required this.controller,
  });

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return  Visibility(
      visible: controller.textController.text.isNotEmpty,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Scan Result",
              style: TextStyle(
                  color: AppColors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 22,
                  letterSpacing: 1)),
          AppSpace.spaceH8,
          SizedBox(
            width: double.infinity,
            child: DottedBorder(
                color: Colors.deepPurpleAccent,
                radius: const Radius.circular(8),
                borderType: BorderType.RRect,
                dashPattern: const [4, 4],
                padding: const EdgeInsets.all(0),
                child: Stack(
                  children: [
                    TextField(
                      scrollPhysics: controller.onEdit? const NeverScrollableScrollPhysics(): const BouncingScrollPhysics(),
                      readOnly: controller.onEdit,
                      style:  TextStyle(
                        fontWeight:controller.onEdit? FontWeight.w400: FontWeight.w500,
                        color: controller.onEdit? AppColors.grey600 : AppColors.black,
                        fontSize: 18,),
                      textAlign: TextAlign.center,
                      controller: controller.textController,
                      maxLines: controller.totalLine,
                      textInputAction: TextInputAction.done,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          focusedErrorBorder: InputBorder.none
                      ),
                    ),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: DottedBorder(
                      color: Colors.deepPurpleAccent,
                      radius: const Radius.circular(8),
                          padding: const EdgeInsets.all(5),
                      borderType: BorderType.RRect,
                      dashPattern: const [4, 4],
                    child: InkWell(
                      onTap: (){},
                        child: Icon(Icons.spatial_audio)),
                    ))
                  ],
                )),
          ),
          AppSpace.spaceH8,

        ],
      ),
    );
  }
}