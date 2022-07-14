import 'package:flutter/material.dart';
import '../../../../../main.dart';

enum SelectLanguage { tiengviet, english }

class LanguageDialog extends StatefulWidget {
  const LanguageDialog({Key? key}) : super(key: key);

  @override
  State<LanguageDialog> createState() => _LanguageDialogState();
}

class _LanguageDialogState extends State<LanguageDialog> {
  SelectLanguage _language = SelectLanguage.english;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      content: Container(
        width: 334,
        constraints: const BoxConstraints(minHeight: 292),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Text(
                      'Chọn ngôn ngữ',
                      style: AppTextTheme.mediumHeaderTitle(AppColor.text1),
                    ),
                  ),
                  SizedBox(
                    width: 40,
                    height: 40,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        primary: AppColor.white,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: SvgIcon(
                        SvgIcons.close,
                        size: 24,
                        color: AppColor.text1,
                      ),
                    ),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: Divider(),
              ),
              radiobutton(
                name: 'Tiếng Việt',
                onChanged: (value) {
                  setState(() {
                    _language = value!;
                  });
                },
                value: SelectLanguage.tiengviet,
              ),
              radiobutton(
                name: 'English',
                onChanged: (value) {
                  setState(() {
                    _language = value!;
                  });
                },
                value: SelectLanguage.english,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 32),
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: AppColor.shade1,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgIcon(
                        SvgIcons.arrowBack,
                        color: AppColor.text1,
                        size: 24,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          'Trở về',
                          style: AppTextTheme.headerTitle(AppColor.text3),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget radiobutton({
    required SelectLanguage value,
    required void Function(SelectLanguage?)? onChanged,
    required String name,
  }) {
    return InkWell(
      splashColor: AppColor.transparent,
      highlightColor: AppColor.transparent,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            SizedBox(
              width: 24,
              child: Radio(
                activeColor: AppColor.text1,
                value: value,
                groupValue: _language,
                onChanged: (value) {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text(
                name,
                style: AppTextTheme.normalText(AppColor.text1),
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        onChanged!(value);
      },
    );
  }
}
