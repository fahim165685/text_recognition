import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text_recognition/app/core/extensions/app_extension.dart';
import 'package:text_recognition/app/global_widget/custom_button.dart';

import '../../../../core/values/app_space.dart';
import '../../controllers/translate_controller.dart';

class TranslateBordOne extends StatelessWidget {
  final TranslateController controller;
  const TranslateBordOne({
    super.key, required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      decoration: BoxDecoration(
          color: const Color(0xFFf7f2fa),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 5, spreadRadius: 1)]),
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 16),
      child: Column(
        children: [
          Row(children: [
            Text(controller.targetLanguage.name.toCapitalize(),style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: Color(0xFF003366)),),
            AppSpace.spaceW12,
            Visibility(
              visible: !controller.textToSpeech1Loading,
              replacement: Transform.scale(scale: 0.6, alignment: Alignment.centerLeft,
                  child: const CircularProgressIndicator(strokeWidth: 4,color: Colors.purple,)),
              child: GestureDetector(onTap: () {controller.textToSpeech1(controller.translateController.text);},
                  child:  Icon( controller.isSpeak1? Icons.volume_up: Icons.volume_down_outlined ,color:const Color(0xFF003366).withOpacity(controller.isSpeak1? 1.0 : 0.5),size: 26,)),
            ),
            const Spacer(),
            GestureDetector(onTap: () => controller.clearData(),
                child: const Icon(Icons.close_rounded,color:Colors.black,size: 26,)),
          ],),
          AppSpace.spaceH16,
          TextField(maxLines: 8, cursorColor: Colors.purple,
            style: const TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w400),
            controller: controller.translateController,
            decoration: const InputDecoration(contentPadding: EdgeInsets.zero,border: InputBorder.none, disabledBorder: InputBorder.none, focusedBorder: InputBorder.none, enabledBorder: InputBorder.none,),),
          AppSpace.spaceH8,
          Align(
              alignment: Alignment.centerRight,
              child: CustomButton(onTap: ()async{
                Get.focusScope?.unfocus();
                await controller.textTranslate(controller.translateController.text);
              },
                text: "Translate",width: 108,height: 40,))
        ],
      ),
    );
  }
}