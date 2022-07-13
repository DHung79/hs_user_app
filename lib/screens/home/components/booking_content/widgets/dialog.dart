import 'package:flutter/material.dart';
import '../../../../../core/task/task.dart';
import '../../../../../widgets/task_widget/task_widget.dart';
import '/main.dart';
import '/widgets/button_widget2.dart';

class DialogWidget extends StatelessWidget {
  const DialogWidget({Key? key, required this.task}) : super(key: key);
  final TaskModel task;
  @override
  Widget build(BuildContext context) {
    return TaskTab(
      task: task,
      nameButton: 'Xem chi tiết',
      onPressed: (model) => showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          content: Container(
            width: 334,
            height: 400,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(4)),
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Text(
                    'Đã nhận việc',
                    style: AppTextTheme.mediumHeaderTitle(AppColor.text1),
                  ),
                ),
                Column(
                  children: [
                    Container(
                      color: AppColor.shade1,
                      height: 1,
                      margin: const EdgeInsets.symmetric(vertical: 16.0),
                    ),
                    SizedBox(
                        width: 100,
                        height: 100,
                        child: Image.asset(
                          'assets/images/logo.png',
                        )),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      'Đã có người nhận công việc của bạn',
                      style: AppTextTheme.normalText(AppColor.text1),
                    ),
                    Container(
                      height: 8,
                      margin: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    ButtonWidget2(
                      name: 'Hiểu rồi',
                      backgroundColor: AppColor.primary2,
                      onPressed: () {},
                      style: AppTextTheme.headerTitle(AppColor.text2),
                      side: BorderSide.none,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    ButtonWidget2(
                      name: 'Xem công việc',
                      backgroundColor: AppColor.shade1,
                      onPressed: () {},
                      style: AppTextTheme.headerTitle(AppColor.text3),
                      side: BorderSide.none,
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
