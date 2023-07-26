import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:text_recognition/app/core/values/app_colors.dart';
import 'package:text_recognition/app/core/values/app_space.dart';


//ignore: must_be_immutable
class CustomDropdown extends StatelessWidget {
  CustomDropdown({
    super.key,
    this.value,
    required  this.items,
    required this.onChanged,
    required this.hintText,
    this.validator,
    required this.helperText,
  });

  TextRecognitionScript? value;
  List items;
  final String hintText;
  final String helperText;
  String? Function(String?)? validator;
  void Function(Object?) onChanged;

  @override
  Widget build(BuildContext context) {
    return   Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(helperText,style: TextStyle(fontSize: 16,color: AppColors.black,fontWeight: FontWeight.w400)),
        AppSpace.spaceH8,
        DropdownButtonFormField(
          value: value,
          items:items.map((e) {
            return DropdownMenuItem(
              value: e,
              child: Text(e.toString().split('.').last,style:  const TextStyle(
                  color: Colors.black,
                  fontSize: 18
              ),),
            );
          }).toList(),
          dropdownColor: Colors.white,
          icon:  Icon(
            Icons.expand_more_rounded,
            color: AppColors.black,
          ),
          onChanged: onChanged,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 20),
            hintText: hintText,
            hintStyle: TextStyle(
              color: AppColors.grey500,
              fontSize: 18,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: AppColors.borderColor
              )
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                    color: AppColors.borderColor
                )
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                    color: AppColors.borderColor
                )
            ),
          ),

        ),
      ],
    );
  }
}
