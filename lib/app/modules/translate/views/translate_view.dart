import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:text_recognition/app/core/values/app_space.dart';
import 'package:text_recognition/app/global_widget/custom_button.dart';

import '../controllers/translate_controller.dart';

class TranslateView extends GetView<TranslateController> {
  const TranslateView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Language Translator'),
        centerTitle: true,
      ),
      body:Padding(
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
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: const Row(
                  children: [
                    Expanded(child: Text("English",style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w500),)),
                    Icon(Icons.swap_horiz),
                    Expanded(child: Text("Spanish",textAlign: TextAlign.right,style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w500),)),
                  ],
                ),
              ),
              AppSpace.spaceH20,
              Container(
                width: Get.width,
                decoration: BoxDecoration(
                    color: const Color(0xFFf7f2fa),
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 5,
                          spreadRadius: 1
                      )
                    ]
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 16),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Text("English",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: Color(0xFF003366)),),
                        AppSpace.spaceW12,
                        GestureDetector(
                            onTap: () {},
                            child: const Icon(Icons.volume_down_outlined,color:Color(0xFF003366),size: 26,)),
                        const Spacer(),
                        GestureDetector(
                            onTap: () {},
                            child: const Icon(Icons.close_rounded,color:Colors.black,size: 26,)),
                      ],),
                    AppSpace.spaceH16,
                    Text("  >_<   "*100),
                    AppSpace.spaceH8,
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: const CircleAvatar(radius: 20,
                            backgroundColor: Color(0xFF003366),
                            child: Icon(Icons.mic),),),
                        const Spacer(),
                        CustomButton(onTap: (){}, text: "Translate",width: 108,height: 40,)
                      ],
                    )
                  ],
                ),
              ),
              AppSpace.spaceH26,
              Container(
                width: Get.width,
                decoration: BoxDecoration(
                    color: const Color(0xFFf7f2fa),
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 5,
                          spreadRadius: 1
                      )
                    ]
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 16),
                child: Column(
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
                    Text("  >_<   "*100),
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
