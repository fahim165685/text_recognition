import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
//import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:text_recognition/app/modules/home/local_widget/select_pick_image_option.dart';

class HomeController extends GetxController {
  final imagePicker = ImagePicker();
  var imageFile = Rx<File?>(null);
  var isPick= false.obs;
  var isConvert= false.obs;
  var isLoading= false.obs;
  var outPutText = "".obs;
  var trText = "".obs;

  ///ModalBottomSheet
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
                child: SelectPickImageOption(
                    onTap: _pickImage
                )
            );
          }),
    );
  }

  ///Pick Image
  Future _pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source, imageQuality: 80);
      if (image == null) return;
      File? img = File(image.path);
      img = await _cropImage(imageFile: img);
      imageFile.value = img!;
      isPick.value = true;
      Get.back();
    } on PlatformException catch (e) {
      isPick.value = true;
      Get.back();
      return Center(child:Text(e.toString()));
    }
  }

  ///Crop Image
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

  void processImage(InputImage image) async {
    isLoading.value = true;
    try{
      final textRecognizer = TextRecognizer();
      log(image.filePath!);
      final RecognizedText recognizedText = await textRecognizer.processImage(image);
      isConvert.value = true;
      for (TextBlock block in recognizedText.blocks) {
        for (TextLine line in block.lines) {
          outPutText.value = "${outPutText.value}${line.text}\n";
        }
      }
      outPutText.value = recognizedText.text;
      ///End busy state
      isLoading.value = false;
    }catch(e){
      print(e);
      isLoading.value= false;
    }
  }

 Future<String?>translateText(String reText) async{
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
 }
}
