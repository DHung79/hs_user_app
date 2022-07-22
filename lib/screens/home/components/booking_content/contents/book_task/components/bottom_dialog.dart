import 'package:flutter/material.dart';
import 'components.dart';

bottomDialog(
  BuildContext context, {
  required String title,
  required String content,
}) {
  showModalBottomSheet(
      isDismissible: false,
      context: context,
      backgroundColor: AppColor.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      builder: (context) {
        return WarningDialog(
          title: title,
          content: content,
        );
      });
}
