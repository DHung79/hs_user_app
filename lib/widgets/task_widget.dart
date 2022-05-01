import 'package:flutter/material.dart';
import 'package:hs_user_app/config/fonts.dart';
import 'package:hs_user_app/config/theme.dart';
import 'package:hs_user_app/models/task_model.dart';

class TaskWidget extends StatelessWidget {
  TaskModel? taskModel;
  TaskWidget({Key? key, this.taskModel}) : super(key: key);
  final List<TaskModel> fakeTasks = [
    TaskModel(
      '0',
      'Don dep theo ngay',
      '17 gio',
      'thu 7 ngay 5',
      'Thang cong',
      'Thu 6',
      '232',
      'Nguyen Phi',
    ),
    TaskModel(
      '1',
      'Don dep theo thang',
      '23 gio',
      'thu 2 ngay 7',
      'That Bai',
      'Thu 3',
      '432',
      'Dao Hung',
    ),
  ];
  final List<Icon> taskIcons = [
    const Icon(
      Icons.alarm,
      color: Color.fromRGBO(33, 169, 159, 1),
    ),
    const Icon(
      Icons.car_rental,
      color: Color.fromRGBO(33, 169, 159, 1),
    ),
    const Icon(
      Icons.draw,
      color: Color.fromRGBO(33, 169, 159, 1),
    ),
    const Icon(
      Icons.escalator,
      color: Color.fromRGBO(33, 169, 159, 1),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        // height: 638,
        height: MediaQuery.of(context).size.height,
        child: FutureBuilder(builder: (context, size) {
          return Container(
            // margin: EdgeInsets.only(top: 142),
            // margin: const EdgeInsets.all(30),
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            color: Colors.white,
            // height: size.maxHeight,
            child: ListView.builder(
                itemCount: fakeTasks.length,
                itemBuilder: (BuildContext context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      padding: EdgeInsets.all(16),
                      // height: 400,
                      // constraints: BoxConstraints(minHeight: 100),
                      // width: 100,
                      // padding: const EdgeInsets.all(16),
                      // margin: const EdgeInsets.only(bottom: 24),
                      decoration: BoxDecoration(
                        // color: Colors.black,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.24),
                              blurStyle: BlurStyle.outer,
                              blurRadius: 10,
                              spreadRadius: 4),
                        ],
                      ),
                      child: Column(
                        children: [
                          _title(task: fakeTasks[index]),
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: taskIcons.length,
                            itemBuilder: (BuildContext context, iconIndex) {
                              return _item(iconIndex, task: fakeTasks[index]);
                            },
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          const Divider(),
                          _profile(task: fakeTasks[index]),
                          const Divider(),
                          const SizedBox(
                            height: 12,
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              'Đăng lại',
                              style: FontStyle().googleFont,
                            ),
                            style: ButtonStyle(
                                padding: MaterialStateProperty.all<EdgeInsets>(
                                  const EdgeInsets.only(
                                      top: 16,
                                      bottom: 16,
                                      left: 110,
                                      right: 110),
                                ),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(4.0),
                                        side: const BorderSide(
                                            color: ColorApp.orangeColor))),
                                side: MaterialStateProperty.all<BorderSide>(
                                    const BorderSide(
                                        width: 1.0,
                                        color: ColorApp.orangeColor))),
                          )
                        ],
                      ),
                    ),
                  );
                }),
          );
        }));
  }

  Widget _item(int i, {required TaskModel task}) {
    String text = '';
    if (i == 0) {
      text = task.datePost;
    } else if (i == 1) {
      text = task.postTime;
    } else if (i == 2) {
      text = task.taskTime;
    } else {
      text = task.userName;
    }
    // print(i++);
    return Container(
      padding: const EdgeInsets.only(top: 9, bottom: 9),
      child: Row(
        children: [
          taskIcons[i],
          const SizedBox(
            width: 10,
          ),
          Text(
            text,
            // style: FontStyle().textTitleFont,
          ),
        ],
      ),
    );
  }

  Widget _title({required TaskModel task}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          children: [
            Text(
              task.title,
              // style: FontStyle().titleFont,
            ),
            Text(
              task.postTime,
              // style: FontStyle().postTimeFont,
            ),
          ],
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: const Color.fromRGBO(243, 244, 244, 1)),
          padding:
              const EdgeInsets.only(top: 4, bottom: 4, right: 12, left: 12),
          child: Text(
            task.taskStatus,
            // style: FontStyle().statusFont,
          ),
        ),
      ],
    );
  }

  Widget _profile({required TaskModel task}) {
    return Container(
      padding: const EdgeInsets.only(top: 12, bottom: 12),
      child: Row(
        children: [
          CircleAvatar(
            child: Image.asset(
              'assets/images/logodemo.png',
              width: 35,
            ),
            backgroundColor: ColorApp.purpleColor,
          ),
          const SizedBox(
            width: 12,
          ),
          Text(
            task.userName,
            // style: FontStyle().textTitleFont,
          )
        ],
      ),
    );
  }
}
