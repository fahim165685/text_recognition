import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:text_recognition/app/core/values/app_space.dart';
import 'package:text_recognition/app/global_widget/custom_button.dart';

import '../controllers/translate_controller.dart';

class TranslateView extends StatelessWidget {
  const TranslateView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Language Translator'),
        centerTitle: true,
      ),
      body:GetBuilder<TranslateController>(
        builder: (controller) {
          return controller.isLoading? const Center(child: CircularProgressIndicator(color: Colors.purpleAccent),) : Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 47,
                    width: Get.width,
                    decoration: BoxDecoration(
                      color: const Color(0xFFf7f2fa),
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 5,
                          spreadRadius: 1
                        )
                      ]
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child:  Row(
                      children: [
                        Expanded(child: Text(controller.formTranslateLanguage.name,style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w500),)),
                        const Icon(Icons.swap_horiz),
                        Expanded(child:
                        PopupMenuButton(
                          position:PopupMenuPosition.under ,
                          offset: const Offset(32, 20),
                          constraints: BoxConstraints(maxHeight: Get.height*0.5,),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            child: Text(controller.toTranslateLanguage.name,textAlign: TextAlign.right,style: const TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w500),),
                          itemBuilder: (context) => List.generate(controller.translateLanguage.length,(index) => PopupMenuItem(
                              value:controller.translateLanguage[index],
                              child:Text(controller.translateLanguage[index].name) ), ),
                          onSelected: (value) => controller.setTranslateLanguage(value),
                        )),
                      ],
                    ),
                  ),
                  AppSpace.spaceH20,
                  Container(
                    width: Get.width,
                    decoration: BoxDecoration(
                        color: const Color(0xFFf7f2fa),
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 5, spreadRadius: 1)]),
                    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 16),
                    child: Column(
                      children: [
                        Row(children: [
                            const Text("English",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: Color(0xFF003366)),),
                            AppSpace.spaceW12,
                            GestureDetector(onTap: () {},
                                child: const Icon(Icons.volume_down_outlined,color:Color(0xFF003366),size: 26,)),
                            const Spacer(),
                            GestureDetector(
                                onTap: () {},
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
                              await controller.textTranslate(controller.translateController.text);
                              },
                              text: "Translate",width: 108,height: 40,))
                      ],
                    ),
                  ),
                  AppSpace.spaceH26,
                  Container(
                    width: Get.width,
                    decoration: BoxDecoration(
                        color: const Color(0xFFf7f2fa),
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 5, spreadRadius: 1)]),
                    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 16),
                    child: controller.isTranslate? const Center(child: CircularProgressIndicator(color: Colors.purpleAccent),) : Column(
                      children: [
                        Row(
                          children: [
                            const Text("English",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: Color(0xFF003366)),),
                            AppSpace.spaceW12,
                            GestureDetector(
                                onTap: () {},
                                child: const Icon(Icons.volume_down_outlined,color:Color(0xFF003366),size: 26,)),
                          ],),
                        AppSpace.spaceH16,
                        Text(controller.translateText,
                          style: const TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w400),),
                        AppSpace.spaceH8,
                        Align(
                          alignment: Alignment.centerRight,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CustomIconButton(onTap: () {}, icon: Icons.content_copy_rounded,),
                              AppSpace.spaceW24,
                              CustomIconButton(onTap: () {}, icon: Icons.share,),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      )
    );
  }
}

class CustomIconButton extends StatelessWidget {
  final Function()? onTap;
  final IconData icon;
  const CustomIconButton({
    super.key,
    required this.onTap,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Icon(icon,color: const Color(0xFF003366),),
    );
  }
}
