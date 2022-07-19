import 'package:flutter/material.dart';
import '../../../main.dart';

class WarningDialog extends StatefulWidget {
  final String title;
  final String content;
  const WarningDialog({
    Key? key,
    this.title = '',
    required this.content,
  }) : super(key: key);

  @override
  State<WarningDialog> createState() => _WarningDialogState();
}

class _WarningDialogState extends State<WarningDialog> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, size) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: Container(
          width: size.maxWidth - 32,
          height: 92,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: AppColor.white,
            boxShadow: [
              BoxShadow(
                color: AppColor.shadow.withOpacity(0.2),
                spreadRadius: 3,
                blurRadius: 8,
                offset: const Offset(0, 0),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 12,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.horizontal(
                    left: Radius.circular(10),
                  ),
                  color: AppColor.others1,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 0, 16),
                  child: IntrinsicHeight(
                    child: Row(
                      children: [
                        Expanded(
                          child: _buildContent(),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: VerticalDivider(
                            thickness: 1.5,
                            color: AppColor.shade1,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: AppButtonTheme.fillRounded(
                            color: AppColor.white,
                            highlightColor: AppColor.white,
                            constraints: const BoxConstraints(
                              minHeight: 40,
                              maxWidth: 40,
                            ),
                            child: SvgIcon(
                              SvgIcons.close,
                              color: AppColor.black,
                              size: 24,
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  _buildContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (widget.title.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Text(
              widget.title,
              style: AppTextTheme.mediumHeaderTitle(AppColor.primary1),
            ),
          ),
        Text(
          widget.content,
          style: AppTextTheme.normalText(AppColor.black),
        ),
      ],
    );
  }
}
