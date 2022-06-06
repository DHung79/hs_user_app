import 'package:flutter/material.dart';
import 'package:hs_user_app/main.dart';
import 'package:hs_user_app/routes/route_names.dart';
import 'package:hs_user_app/theme/svg_constants.dart';
import 'package:hs_user_app/widgets/button_widget2.dart';
import '../../../../core/user/model/user_model.dart';
import '../../../layout_template/content_screen.dart';
import '/models/task_model.dart';

class TaskHistory extends StatefulWidget {
  final void Function()? onPressed;
  final String nameButton;
  final TaskModel? taskModel;
  const TaskHistory({
    Key? key,
    this.taskModel,
    required this.nameButton,
    this.onPressed,
  }) : super(key: key);

  @override
  State<TaskHistory> createState() => _TaskHistoryState();
}

class _TaskHistoryState extends State<TaskHistory> {
  final PageState _pageState = PageState();
  final List<TaskModel> fakeTasks = [
    TaskModel(
      '0',
      'Don dep theo ngay',
      '17 gio',
      'thu 7 ngay 5',
      'Thành công',
      'Thu 6',
      '232',
      'Nguyen Phi',
      true,
    ),
    TaskModel(
      '1',
      'Don dep theo thang',
      '23 gio',
      'thu 2 ngay 7',
      'Thành công',
      'Thu 3',
      '432',
      'Dao Hung',
      true,
    ),
    TaskModel(
      '1',
      'Don dep theo thang',
      '23 gio',
      'thu 2 ngay 7',
      'Thành công',
      'Thu 3',
      '432',
      'Dao Hung',
      false,
    ),
  ];

  final List taskIcons = [
    SvgIcon(
      SvgIcons.accessTime,
      size: 24,
      color: AppColor.shade5,
    ),
    SvgIcon(
      SvgIcons.calenderToday,
      size: 24,
      color: AppColor.shade5,
    ),
    SvgIcon(
      SvgIcons.epLocation,
      size: 24,
      color: AppColor.shade5,
    ),
    SvgIcon(
      SvgIcons.dollar1,
      size: 24,
      color: AppColor.shade5,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return PageTemplate(
      pageState: _pageState,
      onUserFetched: (user) => setState(() {}),
      onFetch: () {
        _fetchDataOnPage();
      },
      appBarHeight: 0,
      child: FutureBuilder(
        future: _pageState.currentUser,
        builder: (context, AsyncSnapshot<UserModel> snapshot) {
          return PageContent(
            child: content(), // child: content(context),
            pageState: _pageState,
            onFetch: () {
              _fetchDataOnPage();
            },
          );
        },
      ),
    );
  }

  FutureBuilder<Object?> content() {
    return FutureBuilder(builder: (context, size) {
      return Container(
        color: Colors.white,
        child: ListView.builder(
            itemCount: fakeTasks.length,
            itemBuilder: (BuildContext context, index) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.24),
                        blurStyle: BlurStyle.outer,
                        blurRadius: 10,
                        spreadRadius: 4,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      _title(task: fakeTasks[index]),
                      Container(
                        margin: const EdgeInsets.only(top: 12),
                        color: AppColor.shade1,
                        height: 1,
                        width: MediaQuery.of(context).size.width,
                      ),
                      fakeTasks[index].isSuccess
                          ? const SizedBox()
                          : infoRemoveTask(),
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
                      const Divider(
                        height: 1,
                      ),
                      _profile(task: fakeTasks[index]),
                      const Divider(
                        height: 1,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      ButtonWidget2(
                        name: 'Xem chi tiết',
                        backgroundColor: AppColor.text2,
                        onPressed: () {
                          navigateTo(viewDetailRoute);
                        },
                        style: AppTextTheme.headerTitle(AppColor.primary2),
                        side: BorderSide(width: 1, color: AppColor.primary2),
                      )
                    ],
                  ),
                ),
              );
            }),
      );
    });
  }

  Container infoRemoveTask() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: AppColor.shade2,
      ),
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          profileRemove(name: 'Người hủy công việc', title: 'Tasker'),
          Container(
            width: 2,
            height: 35,
            color: AppColor.shade1,
          ),
          profileRemove(name: 'Tổng số tiền nhận', title: '300.000 VND'),
        ],
      ),
    );
  }

  Flexible profileRemove({required String name, required String title}) {
    return Flexible(
      flex: 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            name,
            style: AppTextTheme.subText(AppColor.text3),
          ),
          Text(
            title,
            style: AppTextTheme.mediumHeaderTitle(AppColor.primary1),
          )
        ],
      ),
    );
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
      padding: const EdgeInsets.only(top: 12),
      child: Row(
        children: [
          taskIcons[i],
          const SizedBox(
            width: 10,
          ),
          Text(
            text,
            style: AppTextTheme.normalText(AppColor.text1),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              task.title,
              style: AppTextTheme.mediumHeaderTitle(AppColor.primary1),
            ),
            Text(
              task.postTime,
              style: AppTextTheme.normalText(AppColor.text7),
            ),
          ],
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50), color: AppColor.shade1),
          padding:
              const EdgeInsets.only(top: 4, bottom: 4, right: 12, left: 12),
          child: Text(
            task.isSuccess ? 'Thành công' : 'Thất bại',
            style: AppTextTheme.mediumBodyText(
                task.isSuccess ? AppColor.shade9 : AppColor.others1),
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
            backgroundColor: AppColor.nameText,
          ),
          const SizedBox(
            width: 12,
          ),
          Text(
            task.userName,
            style: AppTextTheme.normalText(AppColor.text1),
          )
        ],
      ),
    );
  }
}

void _fetchDataOnPage() {}
