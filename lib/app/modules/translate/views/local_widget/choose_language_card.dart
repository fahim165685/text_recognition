import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text_recognition/app/core/extensions/app_extension.dart';

import '../../../../helper/app_helper.dart';
import '../../controllers/translate_controller.dart';

class ChooseLanguageCard extends StatelessWidget {
  final TranslateController controller;
  const ChooseLanguageCard({
    super.key, required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 47, width: Get.width,
      decoration: BoxDecoration(color: const Color(0xFFf7f2fa),
          borderRadius: BorderRadius.circular(50),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 5, spreadRadius: 1)]),
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child:  Row(
        children: [

          Expanded(child: PopupMenuButton(
            position:PopupMenuPosition.under ,
            offset: const Offset(-32, 20),
            constraints: BoxConstraints(maxHeight: Get.height*0.5,),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child: Row(mainAxisSize: MainAxisSize.min,
              children: [Text(controller.targetLanguage.name.toCapitalize(),style: const TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w500),),
                const Icon(Icons.keyboard_arrow_down,color: Colors.black,),],),

            itemBuilder: (context) => List.generate(controller.translateLanguage.length,(index) => PopupMenuItem(
                value:controller.translateLanguage[index],
                child:Text(controller.translateLanguage[index].name.toCapitalize()) ), ),
            onSelected: (value) {
              AppHelper.miniSuccessSnackBar(massage: "language Feature Coming soon",maxWidth: 300);
            },
          )),

          const Icon(Icons.swap_horiz),

          Expanded(child: PopupMenuButton(
            position:PopupMenuPosition.under ,
            offset: const Offset(32, 20),
            constraints: BoxConstraints(maxHeight: Get.height*0.5,),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Spacer(),
                Text(controller.toTranslateLanguage.name.toCapitalize(),textAlign: TextAlign.right,style: const TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w500),),
                const Icon(Icons.keyboard_arrow_down,color: Colors.black,)
              ],
            ),
            itemBuilder: (context) => List.generate(controller.translateLanguage.length,(index) => PopupMenuItem(
                value:controller.translateLanguage[index],
                child:Text(controller.translateLanguage[index].name.toCapitalize()) ), ),
            onSelected: (value) => controller.setTranslateLanguage(value),
          )),
        ],
      ),
    );}}