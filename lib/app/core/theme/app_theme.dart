import 'package:flutter/material.dart';

import '../values/app_colors.dart';

class AppTheme {
  /// Light Theme
  ThemeData lightTheme = ThemeData.light().copyWith(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.appBgColor,
    appBarTheme: AppBarTheme(
      surfaceTintColor:AppColors.appBgColor,
      backgroundColor: AppColors.white,
      titleTextStyle: const TextStyle(color: Colors.black),
    ),
    brightness: Brightness.light,
    backgroundColor: Colors.white,
    primaryColor: Colors.blue,
    bottomAppBarTheme: BottomAppBarTheme(color: Colors.red),
    iconTheme: IconThemeData(color: AppColors.grey, size: 25.0),
    inputDecorationTheme: inputDecorationTheme(),
    buttonTheme: const ButtonThemeData(
      buttonColor: Colors.blue,
      disabledColor: Colors.grey,
    ),
    drawerTheme: DrawerThemeData(
      backgroundColor: AppColors.white,
    ),
  );

  /// Dark Theme
  ThemeData darkTheme = ThemeData.dark().copyWith(
    useMaterial3: true,
    brightness: Brightness.dark,
    backgroundColor: Colors.black,
    primaryColor: Colors.amber,
    iconTheme: IconThemeData(color: AppColors.white, size: 25.0),
    buttonTheme: const ButtonThemeData(
      buttonColor: Colors.amber,
      disabledColor: Colors.grey,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.black,
      titleTextStyle: const TextStyle(color: Colors.white),
    ),
    drawerTheme: DrawerThemeData(
      backgroundColor: Colors.grey.shade800,
    ),
  );
}
///inputDecorationTheme
InputDecorationTheme inputDecorationTheme() {
  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide:  BorderSide(color: AppColors.borderColor),
    gapPadding: 10,
  );
  OutlineInputBorder focusedBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide:  BorderSide(color: AppColors.appColor.withOpacity(0.5),width: 2,),
    gapPadding: 10,
  );

  OutlineInputBorder enabledBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(color: Color(0xFFe8e8fa)),
    gapPadding: 10,
  );

  return InputDecorationTheme(
    //floatingLabelBehavior: FloatingLabelBehavior.never,
    contentPadding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
    enabledBorder: enabledBorder,
    focusedBorder: focusedBorder,
    border: outlineInputBorder,
    hintStyle: TextStyle(
        color: AppColors.grey200,
        fontSize: 16,
        fontWeight: FontWeight.w400,
        letterSpacing: 1
    ),
  );
}

