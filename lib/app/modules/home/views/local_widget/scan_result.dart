import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import '../../../../core/values/app_colors.dart';
import '../../../../core/values/app_space.dart';
import '../../controllers/home_controller.dart';

class ScanResult extends StatelessWidget {
  const ScanResult({
    super.key,
    required this.homeController,
  });

  final HomeController homeController;

  @override
  Widget build(BuildContext context) {
    return  Visibility(
      visible: homeController.textController.text.isNotEmpty,
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
                      scrollPhysics: homeController.onEdit? const NeverScrollableScrollPhysics(): const BouncingScrollPhysics(),
                      readOnly: homeController.onEdit,
                      style:  TextStyle(
                        fontWeight:homeController.onEdit? FontWeight.w400: FontWeight.w500,
                        color: homeController.onEdit? AppColors.grey600 : AppColors.black,
                        fontSize: 18,),
                      onEditingComplete: () =>homeController.toggleEditText(),
                      textAlign: TextAlign.center,
                      controller: homeController.textController,
                      maxLines: homeController.totalLine,
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
                    Visibility(
                      visible: homeController.onEdit,
                        child: Positioned(
                        top:0 ,
                        right: 0,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(8),
                          onTap: (){homeController.textToSpeech();},
                          child: DottedBorder(
                            color: Colors.deepPurpleAccent,
                            radius: const Radius.circular(8),
                            padding: const EdgeInsets.all(5),
                            borderType: BorderType.RRect,
                            dashPattern: const [4, 4],
                            child: Icon(Icons.volume_up,color: homeController.isSpeak?  const Color(0xFF696969):const Color(0xFFC0C0C0) ,),
                          ),
                        )))

                  ],
                )),
          ),
          AppSpace.spaceH8,

        ],
      ),
    );
  }
}