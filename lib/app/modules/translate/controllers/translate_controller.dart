
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_mlkit_language_id/google_mlkit_language_id.dart';
import 'package:google_mlkit_translation/google_mlkit_translation.dart';
import 'package:text_recognition/app/helper/app_helper.dart';

class TranslateController extends GetxController {

  String formTrLanguage = "English";
  String translateText = "";
  String languageCode = "";
  bool isLoading = false;
  bool isTranslate = false;
  TranslateLanguage toTranslateLanguage =  TranslateLanguage.english;
  TranslateLanguage formTranslateLanguage =  TranslateLanguage.english;
  TextEditingController translateController = TextEditingController();
  List<TranslateLanguage> translateLanguage = TranslateLanguage.values;


  @override
  void onInit() async {
    isLoading = true;
    translateController.text = Get.arguments;
    await languageIdentifier(text:translateController.text, setFormTrLen: true,isNotify: true);
    isLoading = false;
    super.onInit();
  }
  void setTranslateLanguage(TranslateLanguage translateLanguage){
    toTranslateLanguage = translateLanguage;
    update();}

  Future<String> languageIdentifier ({required String text, bool isNotify = false, bool setFormTrLen = false, })async {
    try{
      final langIdentifier = LanguageIdentifier(confidenceThreshold: 0.5);
      final lanCode = await langIdentifier.identifyLanguage(text);
      await langIdentifier.close();
      if(setFormTrLen){
        formTranslateLanguage = TranslateLanguage.values.firstWhere((element) => element.bcpCode ==  lanCode);}

      return lanCode;
    }catch(e){
      print(e);
      return "en";
    }finally{
      if(isNotify){update();}
    }
  }

  Future<void> textTranslate(String reText) async{
    isTranslate = true;
    update();
    try{
      languageCode = await languageIdentifier(text: reText);
      final translator =  OnDeviceTranslator(
          sourceLanguage: TranslateLanguage.values.firstWhere((element) => element.bcpCode ==  languageCode),
          targetLanguage: toTranslateLanguage);
      final trText = await translator.translateText(reText);
      translateText = trText;
      isTranslate = false;
    }catch(e){
      isTranslate = false;
      AppHelper.miniErrorSnackBar();
      print(e);
    }finally{
      isTranslate = false;
      update();
    }
  }

}
