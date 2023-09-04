import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:text_recognition/app/core/values/app_space.dart';

import '../controllers/translate_controller.dart';
import 'local_widget/choose_language_card.dart';
import 'local_widget/translate_bord_one.dart';
import 'local_widget/translate_bord_two.dart';

class TranslateView extends StatelessWidget {
  const TranslateView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Language Translator'),
        centerTitle: true,),
      body:GetBuilder<TranslateController>(
        builder: (controller) {
          return controller.isLoading? const Center(child: CircularProgressIndicator(color: Colors.purpleAccent),) : Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ChooseLanguageCard(controller: controller,),
                  AppSpace.spaceH20,
                  TranslateBordOne(controller: controller),
                  AppSpace.spaceH26,
                  TranslateBordTwo(controller: controller),
                ],
              ),
            ),
          );
        }
      )
    );
  }
}


