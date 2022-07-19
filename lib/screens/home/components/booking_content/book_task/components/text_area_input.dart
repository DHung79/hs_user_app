import 'package:flutter/material.dart';
import '../../../../../../main.dart';

class TextAreaInput extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final String? hintText;
  final TextStyle? hintStyle;
  final int? maxLines;
  final Function(String)? onChanged;
  final Function(String?)? onSaved;
  final String? Function(String?)? validator;
  const TextAreaInput({
    Key? key,
    required this.title,
    required this.controller,
    this.hintText,
    this.hintStyle,
    this.maxLines = 1,
    this.onChanged,
    this.onSaved,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextTheme.mediumHeaderTitle(AppColor.text1),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: TextFormField(
            controller: controller,
            style: AppTextTheme.normalText(AppColor.text1),
            maxLines: maxLines,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: hintStyle ?? AppTextTheme.normalText(AppColor.text7),
              contentPadding: const EdgeInsets.all(16),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: AppColor.text7),
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColor.text7),
                borderRadius: BorderRadius.circular(10),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColor.text7),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onChanged: onChanged,
            onSaved: onSaved,
            validator: validator,
          ),
        )
      ],
    );
  }
}
