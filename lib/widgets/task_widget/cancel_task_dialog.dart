import 'package:flutter/material.dart';
import '../../../main.dart';
import '../../../widgets/jt_dialog.dart';

class CancelTaskDialog extends StatefulWidget {
  final Widget contentHeader;
  final bool isWarning;
  final Function()? onConfirmed;
  final Widget? child;
  const CancelTaskDialog({
    Key? key,
    required this.contentHeader,
    this.isWarning = false,
    this.onConfirmed,
    this.child,
  }) : super(key: key);

  @override
  State<CancelTaskDialog> createState() => _CancelTaskDialogState();
}

class _CancelTaskDialogState extends State<CancelTaskDialog> {
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
              'Hủy công việc',
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
            child: widget.contentHeader,
          ),
          if (widget.child != null) widget.child!,
        ],
      ),
      action: Padding(
        padding: const EdgeInsets.fromLTRB(0, 32, 0, 24),
        child: widget.isWarning ? _warningAction() : _dialogActions(),
      ),
    );
  }

  _dialogActions() {
    return Column(children: [
      AppButtonTheme.fillRounded(
        constraints: const BoxConstraints(
          minHeight: 52,
        ),
        borderRadius: BorderRadius.circular(4),
        color: AppColor.primary2,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgIcon(
              SvgIcons.checkCircleOutline,
              color: AppColor.white,
              size: 24,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Xác nhận',
                style: AppTextTheme.headerTitle(AppColor.white),
              ),
            ),
          ],
        ),
        onPressed: () {
          Navigator.of(context).pop();
          if (widget.onConfirmed != null) {
            widget.onConfirmed!();
          }
        },
      ),
      const SizedBox(height: 16),
      AppButtonTheme.fillRounded(
        constraints: const BoxConstraints(
          minHeight: 52,
        ),
        borderRadius: BorderRadius.circular(4),
        color: AppColor.shade1,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgIcon(
              SvgIcons.close,
              color: AppColor.black,
              size: 24,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Hủy bỏ',
                style: AppTextTheme.headerTitle(AppColor.black),
              ),
            ),
          ],
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    ]);
  }

  _warningAction() {
    return AppButtonTheme.fillRounded(
      constraints: const BoxConstraints(
        minHeight: 52,
      ),
      borderRadius: BorderRadius.circular(4),
      color: AppColor.primary2,
      child: Text(
        'Trở về',
        style: AppTextTheme.headerTitle(AppColor.white),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }
}
