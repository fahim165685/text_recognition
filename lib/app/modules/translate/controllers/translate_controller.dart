
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:google_mlkit_language_id/google_mlkit_language_id.dart';
import 'package:google_mlkit_translation/google_mlkit_translation.dart';
import 'package:share_plus/share_plus.dart';
import 'package:text_recognition/app/helper/app_helper.dart';

class TranslateController extends GetxController {

  bool isSpeak2 = false;
  bool isSpeak1 = false;
  FlutterTts flutterTts = FlutterTts();
  String formTrLanguage = "English";
  String translateText = "";
  bool isLoading = false;
  bool isTranslate = false;
  TranslateLanguage toTranslateLanguage =  TranslateLanguage.english;
  TranslateLanguage targetLanguage =  TranslateLanguage.english;
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

  void clearData(){
    isTranslate = false;
    translateText = "";
    translateController.clear();
    update();}

  bool textToSpeech1Loading = false;
  Future<void> textToSpeech1(String text) async{
    if(isSpeak2){return;}
    try{
      if(!isSpeak1){
        textToSpeech1Loading = true;
        update();
        String code = await languageIdentifier(text: text,);
        flutterTts.setLanguage(code);
        flutterTts.setStartHandler(() => setIsSpeak1(true));
        flutterTts.setCompletionHandler(() =>setIsSpeak1(false));
        await flutterTts.setSpeechRate(0.4);
        await flutterTts.speak(text);
        textToSpeech1Loading = false;
      }else{
        await flutterTts.stop();
        setIsSpeak1(false);}
    }catch(e) {AppHelper.miniErrorSnackBar();}finally{
      textToSpeech1Loading = false;
      update();
    }
  }
  bool setIsSpeak1 (bool value){isSpeak1 = value ;update();return isSpeak1;}


  bool textToSpeech2Loading = false;
  Future<void> textToSpeech2(String text) async{
    if(isSpeak1){return;}
    try{
      if(!isSpeak2){
        textToSpeech2Loading = true;
        update();
        String code = await languageIdentifier(text: text,);
        flutterTts.setLanguage(code);
        flutterTts.setStartHandler(() => setIsSpeak2(true));
        flutterTts.setCompletionHandler(() =>setIsSpeak2(false));
        await flutterTts.setSpeechRate(0.5);
        await flutterTts.speak(text);
      }else{
        await flutterTts.stop();
        setIsSpeak2(false);
      }
    }catch(e) {textToSpeech2Loading = false;
      AppHelper.miniErrorSnackBar();}finally{
      textToSpeech2Loading = false;
      update();
    }
  }
  bool setIsSpeak2 (bool value){isSpeak2 = value;update();return isSpeak2;}


  Future<String> languageIdentifier({required String text, bool isNotify = false, bool setFormTrLen = false, })async {
    try{
      final langIdentifier = LanguageIdentifier(confidenceThreshold: 0.5);
      final lanCode = await langIdentifier.identifyLanguage(text);
      await langIdentifier.close();
      if(setFormTrLen){
        targetLanguage = TranslateLanguage.values.firstWhere((element) => element.bcpCode ==  lanCode);}
      return lanCode;
    }catch(e){
      return "en";
    }finally{
      if(isNotify){update();}
    }
  }

  Future<void> textTranslate(String reText) async{
    if(reText == ""){return;}
    isTranslate = true;
    update();
    try{
      final languageCode = await languageIdentifier(text: reText);
      final matchingLanguage = TranslateLanguage.values.firstWhere((element) => element.bcpCode == languageCode, orElse: () {return TranslateLanguage.english;},);
      if (matchingLanguage.bcpCode == languageCode) {
        targetLanguage = matchingLanguage;
      } else {
        targetLanguage = TranslateLanguage.english;}
      final translator = OnDeviceTranslator(
        sourceLanguage: targetLanguage,
        targetLanguage: toTranslateLanguage,);
      final trText = await translator.translateText(reText);
      translateText = trText;
      isTranslate = false;
    }catch(e){
      isTranslate = false;
      AppHelper.miniErrorSnackBar();
    }finally{
      isTranslate = false;
      update();
    }
  }

  Future<void> copyToClipboard(String text)async {
    if(text==""){return;}
    await Clipboard.setData(ClipboardData(text: text));
    AppHelper.miniSuccessSnackBar(massage: "Text Copy to Clipboard");
  }

  Future<void> shareLink(String text)async {
    if(text==""){return;}
    await Share.share(text);
  }
}
