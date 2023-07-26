import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../views/local_widget/select_pick_image_option.dart';

class HomeController extends GetxController {

  File? imageFile;
  bool isConvert = false;
  bool isLoading = false;
  bool onEdit = true;
  int totalLine = 1;

  TextEditingController textController = TextEditingController();

  TextRecognitionScript selectedScript = TextRecognitionScript.latin;

    List<TextRecognitionScript> scriptList = [
    TextRecognitionScript.chinese,
    TextRecognitionScript.devanagiri,
    TextRecognitionScript.korean,
    TextRecognitionScript.japanese,
    TextRecognitionScript.latin
  ];


    editText(){
      onEdit = !onEdit;
      update();
    }

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source, imageQuality: 80);
      if(image != null){
        File? img = File(image.path);
        img = await _cropImage(imageFile: img);
        imageFile = img!;
        Get.back();
      }else{
        Get.snackbar("Alert", "message");
      }
    } on PlatformException catch (e) {
      Get.back();
      return Center(child:Text(e.toString()));
    }finally{
      update();
    }
  }

  Future<File?> _cropImage({required File imageFile}) async {
    try{
      CroppedFile? croppedImage = await ImageCropper().cropImage(
          sourcePath: imageFile.path,
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Crop Image',
              toolbarColor: Colors.deepPurple.shade400,
              cropFrameColor: Colors.grey,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              cropFrameStrokeWidth: 3,
              lockAspectRatio: false),
          IOSUiSettings(
            title: 'Crop Image',
          ),
        ],

      );
      if (croppedImage == null) return null;
      return File(croppedImage.path);
    }catch(e){print("Error is $e");}
    return null;
  }

  void showSelectPhotoOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      builder: (context) => DraggableScrollableSheet(
          initialChildSize: 0.28,
          maxChildSize: 0.4,
          minChildSize: 0.28,
          expand: false,
          builder: (context, scrollController) {
            return SingleChildScrollView(
                controller: scrollController,
                child: SelectPickImageOption(onTap: pickImage));
          }),
    );
  }


  void processImage(InputImage image) async {
    isLoading = true;
    textController.clear();
    update();
    try{
      final textRecognizer = TextRecognizer(script: selectedScript);
      log(image.filePath!);
      final RecognizedText recognizedText = await textRecognizer.processImage(image);
      isConvert = true;
      for (TextBlock block in recognizedText.blocks) {
        for (TextLine line in block.lines) {
          totalLine++;
          textController.text = "${textController.value.text}${line.text}\n";
        }
      }
      //outPutText.value = recognizedText.text;
      ///End busy state
      isLoading = false;
    }catch(e){
      print(e);
      isLoading = false;
    }finally{
      update();
    }
  }

 /*Future<String?>translateText(String reText) async{
    try{
      final langIdentifier = LanguageIdentifier(confidenceThreshold: 0.5);
      final languageCode = await langIdentifier.identifyLanguage(reText);
      langIdentifier.close();
      final tr = OnDeviceTranslatorModelManager();
      final translator =  OnDeviceTranslator(
          sourceLanguage: TranslateLanguage.values.firstWhere((element) => element.bcpCode == languageCode),
          targetLanguage: TranslateLanguage.japanese);
      final translateText = await translator.translateText(reText);
      trText.value= translateText;
      translator.close();
       return translateText;
    }catch(e){
      return null;
    }
 }*/
}
