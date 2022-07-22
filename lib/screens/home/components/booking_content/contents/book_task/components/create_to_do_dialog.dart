import 'package:flutter/material.dart';
import 'components.dart';

class CreateToDoDialog extends StatefulWidget {
  final Function(String) onPressed;
  const CreateToDoDialog({Key? key, required this.onPressed}) : super(key: key);

  @override
  State<CreateToDoDialog> createState() => _CreateToDoDialogState();
}

class _CreateToDoDialogState extends State<CreateToDoDialog> {
  final _key = GlobalKey<FormState>();
  AutovalidateMode _autovalidate = AutovalidateMode.disabled;
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenSzie = MediaQuery.of(context).size;
    return AlertDialog(
      content: Form(
        key: _key,
        autovalidateMode: _autovalidate,
        child: Container(
          width: screenSzie.width - 40,
          constraints: const BoxConstraints(minHeight: 216),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Text(
                  'Thêm công việc',
                  style: AppTextTheme.mediumHeaderTitle(AppColor.text1),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Divider(),
              ),
              Container(
                width: screenSzie.width - 40,
                constraints: const BoxConstraints(minHeight: 52),
                child: TextFormField(
                  controller: _controller,
                  style: AppTextTheme.mediumBodyText(AppColor.text3),
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: 'Nhập tên công việc',
                    hintStyle: AppTextTheme.normalText(AppColor.text7),
                    fillColor: AppColor.shade1,
                    filled: true,
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColor.text7, width: 2),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColor.text7, width: 2),
                    ),
                  ),
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return ValidatorText.empty(fieldName: 'Tên công việc');
                    }
                    if (value.trim().length > 50) {
                      return ValidatorText.moreThan(
                        fieldName: 'Tên công việc',
                        moreThan: 50,
                      );
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 40, 0, 16),
                child: AppButtonTheme.fillRounded(
                  color: AppColor.primary2,
                  constraints: const BoxConstraints(minHeight: 52),
                  borderRadius: BorderRadius.circular(4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgIcon(
                        SvgIcons.add,
                        size: 24,
                        color: AppColor.text2,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          'Thêm',
                          style: AppTextTheme.headerTitle(AppColor.text2),
                        ),
                      )
                    ],
                  ),
                  onPressed: () {
                    if (_key.currentState!.validate()) {
                      _key.currentState!.save();
                      widget.onPressed(_controller.text);
                      Navigator.pop(context);
                    } else {
                      setState(() {
                        _autovalidate = AutovalidateMode.onUserInteraction;
                      });
                    }
                  },
                ),
              ),
              AppButtonTheme.fillRounded(
                color: AppColor.shade1,
                constraints: const BoxConstraints(minHeight: 52),
                borderRadius: BorderRadius.circular(4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgIcon(
                      SvgIcons.close,
                      size: 24,
                      color: AppColor.text3,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        'Hủy bỏ',
                        style: AppTextTheme.headerTitle(AppColor.text3),
                      ),
                    )
                  ],
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
