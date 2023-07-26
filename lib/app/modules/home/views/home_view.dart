import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text_recognition/app/core/values/app_colors.dart';
import 'package:text_recognition/app/core/values/app_space.dart';
import 'package:text_recognition/app/global_widget/custom_app_bar.dart';

import '../controllers/home_controller.dart';
import 'local_widget/dropdown.dart';
import 'local_widget/home_bottom_button.dart';
import 'local_widget/image_field.dart';
import 'local_widget/scan_result.dart';
import 'local_widget/upload_or_scan_button.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (homeController) {
        return Scaffold(
            appBar: const CustomAppBar(title: "Text Reorganization",),
            body: HomeBody(homeController: homeController,),
            floatingActionButton: InkWell(
              onTap: (){
                showDialog(context: context,
                  barrierDismissible: false,
                  builder: (context) => WillPopScope(
                    onWillPop: () async {
                      return false;
                    },
                    child: Dialog(
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    child: CircularProgressIndicator(),

                ),
                  ),);
              },
              borderRadius: BorderRadius.circular(50),
              child: CircleAvatar(
                radius:30,
                backgroundColor: Colors.deepPurpleAccent.shade100.withOpacity(0.2),
                child: const Icon(Icons.history,color: AppColors.appColor,size: 40,),
              ),
            ),
          bottomNavigationBar:Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: HomeBottomButton(homeController: homeController,),
          ),

        );
      }
    );
  }
}

class HomeBody extends StatelessWidget {
  const HomeBody({
    super.key,
    required this.homeController,});

  final HomeController homeController;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppSpace.spaceH30,
            ImageField(controller: homeController),
            AppSpace.spaceH30,

            Dropdown(controller: homeController,),
            AppSpace.spaceH20,
            //Button
            UploadOrScanButton(controller: homeController,),

            AppSpace.spaceH20,
            //Output
            ScanResult(controller: homeController),
            AppSpace.spaceH16,
            //Icon Button
            AppSpace.spaceH44
          ],
        ),

    );
  }
}









