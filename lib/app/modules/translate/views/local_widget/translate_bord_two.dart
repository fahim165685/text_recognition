
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text_recognition/app/core/extensions/app_extension.dart';

import '../../../../core/values/app_space.dart';
import '../../controllers/translate_controller.dart';

class TranslateBordTwo extends StatelessWidget {
  final TranslateController controller;
  const TranslateBordTwo({
    super.key, required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      decoration: BoxDecoration(color: const Color(0xFFf7f2fa), borderRadius: BorderRadius.circular(8),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 5, spreadRadius: 1)]),
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 16),
      child: controller.isTranslate? const Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
          CircularProgressIndicator(color: Colors.purple),
        AppSpace.spaceH6,
        Text("Downloading Language...")
        ],
      ),) : Column(
        children: [
          Row( children: [
            Text(controller.toTranslateLanguage.name.toCapitalize(),style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: Color(0xFF003366)),),
            AppSpace.spaceW12,

            Visibility(
              visible: !controller.textToSpeech2Loading,
              replacement: Transform.scale(scale: 0.6,alignment: Alignment.centerLeft,
                  child: const CircularProgressIndicator(strokeWidth: 4,color: Colors.purple,)),
              child: GestureDetector(onTap: () {controller.textToSpeech2(controller.translateText);},
                  child:  Icon( controller.isSpeak2? Icons.volume_up: Icons.volume_down_outlined ,color:const Color(0xFF003366).withOpacity(controller.isSpeak2? 1.0 : 0.5),size: 26,)),),],),

          AppSpace.spaceH16,

          Align(alignment: Alignment.topLeft,
            child: SelectableText(controller.translateText, style: const TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w400),),),

          AppSpace.spaceH8,
          Align(alignment: Alignment.centerRight,
            child: Row(mainAxisSize: MainAxisSize.min,
              children: [
                _CustomIconButton(onTap: () =>controller.copyToClipboard(controller.translateText), icon: Icons.content_copy_rounded,),
                AppSpace.spaceW24,
                _CustomIconButton(onTap: () async =>await controller.shareLink(controller.translateText), icon: Icons.share,),
              ],),)],),);}
}

class _CustomIconButton extends StatelessWidget {
  final Function()? onTap;
  final IconData icon;
  const _CustomIconButton({
    required this.onTap,
    required this.icon,});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Icon(icon,color: const Color(0xFF003366),),
    );
  }
}