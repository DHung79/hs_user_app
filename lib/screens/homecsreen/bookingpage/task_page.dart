import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:home_services/config/fonts.dart';
import 'package:home_services/widgets/task_widget.dart';

class TaskPage extends StatelessWidget {
  const TaskPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // resizeToAvoidBottomInset: false,
      height: MediaQuery.of(context).size.height,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(255, 158, 24, 1),
                        padding: const EdgeInsets.only(top: 16, bottom: 16)),
                    onPressed: () {},
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/icons/17077.svg',
                            color: Colors.white,
                          ),
                          const SizedBox(
                            width: 14,
                          ),
                          Text(
                            'ĐĂNG VIỆC MỚI NGAY',
                            style: FontStyle().registerFont,
                          ),
                        ]),
                  ),
                  Padding(
                    child: Text(
                      'Việc từng đăng',
                      style: FontStyle().Tasked,
                    ),
                    padding: const EdgeInsets.only(top: 24),
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              child: TaskWidget(),
            )
          ]),
    );
  }
}
