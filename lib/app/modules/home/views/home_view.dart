
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:text_recognition/app/global_widget/custom_button.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple.shade300,
          title: const Text('Text Recognition'),
          centerTitle: true,
        ),
        body: Obx(
          () => Center(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  controller.isPick.value == false
                      ? DottedBorder(
                          borderType: BorderType.RRect,
                          radius: const Radius.circular(8),
                          strokeWidth: 2,
                          dashPattern: const [4, 4],
                          child: SizedBox(
                            width: double.infinity,
                            height: 200,
                            child: Center(
                              child: SvgPicture.asset("assets/icons/upload.svg",
                                  color: Colors.black, width: 50, height: 50),
                            ),
                          ),
                        )
                      : Container(
                          margin: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Image.file(controller.imageFile.value!),
                        ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: CustomButton(
                              showBorderOnly: true,
                              text: "Upload Image",
                              onTap: () =>
                                  controller.showSelectPhotoOptions(context))),
                      const SizedBox(
                        width: 10,
                      ),
                      if(controller.isPick.value==true)
                      Expanded(
                          child: CustomButton(
                            icon: controller.isLoading.value?const CircularProgressIndicator():null ,
                              text: "Convert To Text",
                              onTap: (controller.isLoading.value)?null: (){
                                  final InputImage inputImage = InputImage.fromFilePath(controller.imageFile.value!.path);
                                  controller.processImage(inputImage);
                              }))
                    ],
                  ),
                  const SizedBox(height: 30,),
                  if(controller.outPutText.isEmpty==false)
                  SizedBox(
                    width: double.infinity,
                    child: DottedBorder(
                      color: Colors.deepPurpleAccent,
                        radius:const Radius.circular(15),
                        borderType: BorderType.RRect,
                        dashPattern: const [4,4],
                        padding: const EdgeInsets.all(15),
                        child: Center(
                          child: Text(controller.outPutText.value,textAlign: TextAlign.center,style: const TextStyle(
                            color: Colors.black,
                            fontSize: 25
                          ),),
                        )),
                  ),
                  const SizedBox(height: 20,),
                  if(controller.isConvert.value==true)
                  CustomButton(
                      icon: const Icon(Icons.translate,color: Colors.white),
                      text: "Translate To Bangle",
                      onTap: (){
                        //final InputImage inputImage = InputImage.fromFilePath(controller.imageFile.value!.path);
                        controller.translateText(controller.outPutText.value);
                      }),
                  const SizedBox(height: 30,),
                  if(controller.trText.isEmpty==false)
                    SizedBox(
                      width: double.infinity,
                      child: DottedBorder(
                          color: Colors.greenAccent,
                          radius:const Radius.circular(15),
                          borderType: BorderType.RRect,
                          dashPattern: const [4,4],
                          padding: const EdgeInsets.all(15),
                          child: Center(
                            child: Text(controller.trText.value,textAlign: TextAlign.center,style: const TextStyle(
                                color: Colors.green,
                                fontSize: 25
                            ),),
                          )),
                    ),
                ],
              ),
            ),
          ),
        ));
  }
}
