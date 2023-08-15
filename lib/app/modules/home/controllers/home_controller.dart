import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:google_mlkit_language_id/google_mlkit_language_id.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:google_mlkit_translation/google_mlkit_translation.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:text_recognition/app/helper/app_helper.dart';

import '../views/local_widget/select_pick_image_option.dart';

class HomeController extends GetxController {

  FlutterTts flutterTts = FlutterTts();
  File? imageFile;
  bool isConvert = false;
  bool isLoading = false;
  bool isSpeak = false;
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


  bool toggleEditText(){
      onEdit = !onEdit;
      update();
      return onEdit;}

  bool setIsSpeak (bool value){
      isSpeak = value ;
      update();
      return isSpeak;}

  Future<void> textToSpeech() async{
      try{
        if(!isSpeak){
          flutterTts.setStartHandler(() => setIsSpeak(true));
          flutterTts.setCompletionHandler(() =>setIsSpeak(false));
          await flutterTts.setSpeechRate(0.4);
          await flutterTts.speak(textController.text);
        }else{
         await flutterTts.stop();
         setIsSpeak(false);
        }
      }catch(e) {AppHelper.miniErrorSnackBar();}
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

  void copyToClipboard()async {
    await Clipboard.setData(ClipboardData(text: textController.text));
    AppHelper.miniSuccessSnackBar(massage: "Text Copy to Clipboard");
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
    totalLine = 1;
    textController.clear();
    update();
    try{
      TextRecognizer textRecognizer = TextRecognizer(script: selectedScript);
      //log(image.filePath!);
      RecognizedText? recognizedText = await textRecognizer.processImage(image);
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
      print("87554545213$e");
      isLoading = false;
    }finally{
      update();
    }
  }
}
