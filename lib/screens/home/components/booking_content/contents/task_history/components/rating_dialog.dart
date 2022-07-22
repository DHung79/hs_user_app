import 'package:flutter/material.dart';
import '../../../../../../../widgets/jt_dialog.dart';
import 'components.dart';

class RatingDialog extends StatelessWidget {
  final Widget contentHeader;
  final Function()? onPressed;
  const RatingDialog({
    Key? key,
    required this.contentHeader,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return JTDialog(
      header: Padding(
        padding: const EdgeInsets.only(top: 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Đánh giá người giúp việc',
              style: AppTextTheme.mediumHeaderTitle(AppColor.black),
            ),
          ],
        ),
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: contentHeader,
          ),
        ],
      ),
      action: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 24),
        child: AppButtonTheme.fillRounded(
          constraints: const BoxConstraints(
            minHeight: 52,
          ),
          borderRadius: BorderRadius.circular(4),
          color: AppColor.primary2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  'Gửi đánh giá',
                  style: AppTextTheme.headerTitle(AppColor.white),
                ),
              ),
            ],
          ),
          onPressed: onPressed,
        ),
      ),
    );
  }
}
